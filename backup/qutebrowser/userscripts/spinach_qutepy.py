#!/usr/bin/python

import os
import sys
import typing
import pprint
import tempfile
import subprocess


class Qute:
    def __init__(self) -> None:
        self.env = {k: v for k, v in os.environ.items()
                    if k.startswith('QUTE')}
        self.mode = self.get_env('mode')
        self.user_agent = self.get_env('user_agent')
        self.fifo = open(self.get_env('fifo'), 'w')
        self.url = self.get_env('url')
        self.title = self.get_env('title')
        self.config_dir = self.get_env('config_dir')
        self.data_dir = self.get_env('data_dir')
        self.download_dir = self.get_env('download_dir')

    def get_env(self, name: str) -> str:
        return self.env[f'QUTE_{name.upper()}']

    def __del__(self) -> None:
        if self.fifo and not self.fifo.closed:
            self.fifo.close()

    def exec(self, cmd: str) -> bool:
        Helper.log('run command', cmd)
        print(cmd, file=self.fifo)
        return True

    def open_url(self, url: str, new_window: bool = False, new_tab: bool = False) -> bool:
        if url is None:
            return False
        option = ''
        if new_window:
            option += '-w'
        if new_tab:
            option += '-t'
        return self.exec(f'open {option} {url}')


class Helper:
    @staticmethod
    def log(pre: str, obj: typing.Any):
        print(pre, end=': ', file=sys.stdout)
        pprint.pprint(obj, stream=sys.stdout)
        print(f'{pre}: {obj}', file=sys.stderr)

    @staticmethod
    def readfile(path: str) -> str:
        content = None
        with open(path) as f:
            content = f.read()
        return content

    bat_preview = r'''--preview \
            'bat {} \
                --language css \
                --color always \
                --paging never \
                --line-range :500 \
            ' \
    '''
    T = typing.TypeVar('T')

    @staticmethod
    def fzf_select(src: typing.List[T], multi: bool = False, preview: typing.Union[str, None] = bat_preview) -> typing.List[T]:
        tmpf = tempfile.NamedTemporaryFile(prefix='/tmp/spinach_i3_sysctrl.py', mode='w+')
        srcmap = {str(i): i for i in src}
        stream = '\\n'.join(srcmap.keys())
        cmd = rf'''
            echo -n -e {stream} \
            | fzf \
                {'--multi' if multi else ''} \
                {preview if preview else ''}\
            > {tmpf.name}
            '''
        subprocess.run(['alacritty', '-e', 'fish', '-c', cmd])
        tmpf.seek(0)
        selected = [
            srcmap[i]
            for i in tmpf.read().split('\n')
            if i in srcmap
        ]
        tmpf.close()

        Helper.log('selected:', selected)
        return selected
