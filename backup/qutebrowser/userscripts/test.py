#!/usr/bin/python
import subprocess
import os
import sys
import tempfile
import typing
import argparse


def qute_available() -> bool:
    return 'QUTE_FIFO' in os.environ


def qute_exec(cmd: str) -> None:
    print(f'qute_exec {cmd}', file=sys.stderr)
    if not qute_available():
        return None
    with open(os.environ['QUTE_FIFO'], 'w') as f:
        print(cmd, file=f)


def chain(funcs) -> typing.Callable[[], None]:
    def wrapper():
        head, tail = funcs[0], funcs[1:]
        v = head()
        if v == None:
            return None
        for f in tail:
            v = f(v)
            if v == None:
                break
    return wrapper


def parse_bookmark_item(raw: str) -> str:
    return raw


def select_bookmark_item() -> typing.Union[str, None]:
    bookmarks_directory = os.path.join(
        os.environ['HOME'], '.config', 'qutebrowser', 'spinach-bookmarks')

    tmpfile = tempfile.NamedTemporaryFile(
        prefix='/tmp/spinach-bookmarks_selector', mode='w+')
    subprocess.run(args=['alacritty', '-e', 'ranger',
                   bookmarks_directory, '--choosefile', tmpfile.name])
    tmpfile.seek(0)
    selected_item = tmpfile.read()
    tmpfile.close()

    if os.path.isfile(selected_item):
        with open(selected_item, 'r') as f:
            return parse_bookmark_item(f.read().strip())
    return None


def open_url(url: str, new_window: bool = False, new_tab: bool = False) -> None:
    option = ''
    if new_window:
        option += '-w'
    if new_tab:
        option += '-t'
    qute_exec(f'open {option} {url}')


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='spinach bookmarks manager for qutebrowser')
    parser.add_argument('-t',action='store_const',const=True)
    parser.add_argument('-w',action='store_const',const=True)
    res = parser.parse_args(sys.argv[1:])

    handler = chain([select_bookmark_item, lambda u: open_url(u, new_window=res.w, new_tab=res.t)])
    handler()
