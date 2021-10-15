#!/usr/bin/python

import os
import sys
import typing
import pprint


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