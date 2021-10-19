from __future__ import annotations
from typing import Any, Dict, List, Union, TypeVar
from datetime import datetime
import sys
import subprocess
import tempfile
import yaml
import argparse
from pprint import pprint


class Helper:
    @staticmethod
    def log(pre: str, msg: Any) -> None:
        path = '/tmp/spinach_i3_sysctrl.py.log'
        with open(path, 'a') as f:
            print(pre, file=f)
            pprint(msg, stream=f)
            print('', file=f)

    @staticmethod
    def info(abs: str, msg: Any) -> None:
        ts = datetime.now().strftime('%H:%M:%S')
        Helper.log(f'INFO(ts={ts}): {abs}', msg)

    @staticmethod
    def err(abs: str, msg: Any) -> None:
        ts = datetime.now().strftime('%H:%M:%S')
        Helper.log(f'ERROR(ts={ts}): {abs}', msg)

    @staticmethod
    def readfile(path: str) -> str:
        with open(path) as f:
            return f.read()

    T = TypeVar('T')

    @staticmethod
    def fzf_select(src: List[T], preview: Union[str, None] = None) -> List[T]:
        tmpf = tempfile.NamedTemporaryFile(prefix='/tmp/sp-qb-sel', mode='w+')
        srcmap = {str(i): i for i in src}
        stream = '\\n'.join(srcmap.keys())
        cmd = rf'''echo -n -e {stream} \
            | fzf {preview if preview else ''}\
            > {tmpf.name}
            '''
        Helper.shell_run(cmd)
        tmpf.seek(0)
        selected = [
            srcmap[i]
            for i in tmpf.read().split('\n')
            if i in srcmap
        ]
        tmpf.close()

        Helper.info('selected:', selected)
        return selected

    @staticmethod
    def shell_run(cmd: str) -> None:
        subprocess.run(['fish', '-c', cmd])

    @staticmethod
    def shell_run_backgound(cmd: str) -> None:
        '''
        see https://stackoverflow.com/questions/10408816/how-do-i-use-the-nohup-command-without-getting-nohup-out
        see https://stackoverflow.com/questions/20646519/how-to-spawn-a-new-independent-process-in-python
        '''
        Helper.info('running', cmd)
        subprocess.Popen(['nohup', 'fish', '-c', cmd],
                         stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)


class FzfMenuEntry:
    def __init__(self, key: str, desc: str, son: Union[None, List[FzfMenuEntry]], action: Union[None, str]) -> None:
        assert('/' not in key and '\n' not in desc)
        assert(son is not None or action is not None)
        assert(son is None or action is None)
        self.key = key
        self.desc = desc
        self.son = son
        self.action = action

    def expand_to_leaf(self, path) -> dict[str, FzfMenuEntry]:
        path = f'{path}/{self.key}'
        d = dict()
        if self.action is not None:
            d |= {path: self}
        if self.son is not None:
            for s in self.son:
                d |= s.expand_to_leaf(path)
        return d

    def expand_all(self, path) -> dict[str, FzfMenuEntry]:
        path = f'{path}/{self.key}'
        d = {path: self}
        if self.son is not None:
            for s in self.son:
                d |= s.expand_all(path)
        return dict(d.items())

    @staticmethod
    def parse(doc: Dict[str, Any]) -> FzfMenuEntry:
        keys = list(doc.keys())
        assert(len(keys) == 1)
        key = keys[0]
        obj = doc[key]
        assert('desc' in obj)
        assert('son' in obj or 'action' in obj)
        assert(not ('son' in obj and 'action' in obj))
        desc = obj['desc']
        if 'son' in obj:
            son = [FzfMenuEntry.parse(i) for i in obj['son']]
            return FzfMenuEntry(key, desc, son, None)
        else:
            return FzfMenuEntry(key, desc, None, obj['action'])


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('mode', metavar='mode',
                        choices=['mixed', 'expanded', 'level', 'preview'],
                        help='OneOf[mixed, expanded, level, preview]. Way to show the menu; preview for fzf-preview command')
    parser.add_argument('menu_file', metavar='menu',
                        action=argparse._StoreAction,
                        help='path to menu.yaml')
    parser.add_argument('--entry_path', metavar='path',
                        action=argparse._StoreAction, default='/',
                        help='used for fzf-preview, the path of the menu-entry under cursor')
    args = parser.parse_args(sys.argv[1:])
    Helper.info('arguments', args)

    mode: str = args.mode

    menu_file: str = args.menu_file
    doc = yaml.safe_load(Helper.readfile(menu_file))
    root = FzfMenuEntry.parse(doc)

    all_leafs = root.expand_to_leaf('')
    all_entries = root.expand_all('')

    fzf_preview_cmd = rf'''--preview \
        'python {sys.argv[0]} --entry_path '{{}}' preview {menu_file} \
        | bat \
            --file-name MenuEntry-preview \
            --language fish \
            --color always \
            --paging never \
            --line-range :500 \
        ' \
    '''

    if mode == 'preview':
        entry_path: str = args.entry_path
        entry = all_entries.get(entry_path)
        Helper.info('previewing', yaml.dump(entry))
        if entry:
            if entry.son is not None:
                print(f'Group({entry.key})')
                print(f'description={entry.desc}')
            if entry.action is not None:
                print(f'Action({entry.key})')
                print(f'description={entry.desc}')
                print('')
                print(entry.action)
    elif mode == 'level':
        entry = root
        while entry and not entry.action and entry.son:
            choices = {s.key: s for s in entry.son}
            selected = Helper.fzf_select(list(choices.keys()))
            if len(selected) > 0:
                entry = choices.get(selected[0])
            else:
                break
        if entry and entry.action:
            Helper.shell_run_backgound(entry.action)
    elif mode == 'expanded':
        selected = Helper.fzf_select(
            list(all_leafs.keys()), preview=fzf_preview_cmd)
        if len(selected) > 0:
            entry = all_leafs.get(selected[0])
            if entry and entry.action:
                Helper.shell_run_backgound(entry.action)
    else:
        Helper.err('unknown mode', mode)


if __name__ == '__main__':
    main()
