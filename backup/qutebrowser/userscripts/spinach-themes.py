#!/usr/bin/python

import subprocess
import os
import sys
import tempfile
import typing
import pprint


class Qute:
    def __init__(self) -> None:
        self.env = {k: v for k, v in os.environ.items()
                    if k.startswith('QUTE')}
        self.fifo = open(self.env['QUTE_FIFO'], 'w')
        self.config_dir = self.env['QUTE_CONFIG_DIR']
        self.data_dir = self.env['QUTE_DATA_DIR']
        pass

    def __del__(self) -> None:
        if self.fifo and not self.fifo.closed:
            self.fifo.close()

    def exec(self, cmd: str) -> bool:
        Helper.log('run command', cmd)
        print(cmd, file=self.fifo)
        return True


class Helper:
    @staticmethod
    def log(pre: str, obj: typing.Any):
        print(pre,end=': ',file=sys.stdout); pprint.pprint(obj, stream=sys.stdout)
        print(f'{pre}: {obj}',file=sys.stderr)

    @staticmethod
    def chain(funcs: typing.List[typing.Callable[[typing.Any], typing.Any]], start: typing.Any) -> typing.Callable[[], typing.Any]:
        def wrapper() -> typing.Any:
            v = start
            if v is None:
                return v
            for f in funcs:
                v = f(v)
                if v is None:
                    break
            return v
        return wrapper

    @staticmethod
    def readfile(path: str) -> str:
        content = None
        with open(path) as f:
            content = f.read()
        return content


def get_themes_all(themes_dir: str) -> typing.List[str]:
    os.chdir(themes_dir)
    themes = [
        path
        for path
        in subprocess.check_output(['fd', '--type', 'file', '--extension', 'css', '--', 'all-sites']).decode().split('\n')
        if os.path.isfile(path)
    ]
    Helper.log('all available themes', themes)
    return themes


def select_theme(all_themes: typing.List[str]) -> typing.Union[str, None]:
    tmpf = tempfile.NamedTemporaryFile(
        prefix='/tmp/spinach-themes-selector', mode='w+')
    all_themes.append('No User Stylesheet')
    themes_stream = '\\n'.join(all_themes)
    cmd = rf'''
        echo -n -e {themes_stream} \
        | fzf \
            --preview \
                'bat {{}} \
                    --language css \
                    --color always \
                    --paging never \
                    --line-range :500 \
                ' \
        > {tmpf.name}
        '''
    subprocess.run(['alacritty', '-e', 'fish', '-c', cmd])
    tmpf.seek(0)
    selected = tmpf.read().strip()
    tmpf.close()

    if not os.path.isfile(selected):
        selected = None
    Helper.log('selected theme', selected)
    return selected


if __name__ == '__main__':
    qute = Qute()

    themes_dir = os.path.join(qute.config_dir, 'userstyles')
    os.chdir(themes_dir)
    themes = get_themes_all(themes_dir)
    selected = select_theme(themes)
    selected = os.path.join(themes_dir,selected) if selected is not None else '\'\''
    qute.exec(f':set -tp content.user_stylesheets {selected}')
