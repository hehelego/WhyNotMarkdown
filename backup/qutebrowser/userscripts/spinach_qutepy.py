#!/usr/bin/python

import os
from pprint import pprint
import subprocess
import sys
import tempfile
from typing import Any, List, TypeVar, Union


class Qute:
    def __init__(self) -> None:
        self.env = {k: v for k, v in os.environ.items()
                    if k.startswith('QUTE')}
        self.mode = self.get_env('mode')
        self.user_agent = self.get_env('user_agent')
        self.fifo = open(self._ge('fifo'), 'w')
        self.url = self.get_env('url')
        self.title = self.get_env('title')
        self.config_dir = self._ge('config_dir')
        self.data_dir = self._ge('data_dir')
        self.download_dir = self._ge('download_dir')

    def get_env(self, name: str) -> Union[str, None]:
        return self.env.get(f'QUTE_{name.upper()}')
    def _ge(self, name: str) -> str:
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
    def log(pre: str, obj: Any):
        print(pre, end=': ', file=sys.stdout)
        pprint(obj, stream=sys.stdout)
        print(f'{pre}: {obj}', file=sys.stderr)

    T_not_none = TypeVar('T_not_none')

    @staticmethod
    def not_none(x: Union[T_not_none, None]) -> T_not_none:
        assert(x is not None)
        return x

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
    T_fzf_select = TypeVar('T_fzf_select')

    @staticmethod
    def fzf_select(src: List[T_fzf_select], multi: bool = False, preview: Union[str, None] = bat_preview) -> List[T_fzf_select]:
        input_file = tempfile.NamedTemporaryFile(
            prefix='/tmp/spinach_i3_sysctrl.py', mode='w+')
        output_file = tempfile.NamedTemporaryFile(
            prefix='/tmp/spinach_i3_sysctrl.py', mode='w+')
        src_map = {str(i): i for i in src}
        for i in src_map.keys():
            print(i, file=input_file)
        input_file.flush()
        cmd = rf'''
            cat {input_file.name} \
            | fzf \
                {'--multi' if multi else ''} \
                {preview if preview else ''}\
            > {output_file.name}
            '''
        subprocess.run(['alacritty', '-e', 'fish', '-c', cmd])
        output_file.seek(0)
        selected = [
            src_map[i]
            for i in output_file.read().split('\n')
            if i in src_map
        ]
        output_file.close()
        input_file.close()

        Helper.log('selected:', selected)
        return selected
