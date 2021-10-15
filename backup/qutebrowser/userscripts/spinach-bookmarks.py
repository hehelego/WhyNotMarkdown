#!/usr/bin/python

from spinach_qute_userscript_base import Qute, Helper

import subprocess
import os
import sys
import tempfile
import typing
import yaml
import argparse


class Bookmark:
    '''
    entires:
        - url
        - name
        - tags
    '''

    def __init__(self, url: str, name: str, tags: typing.List[str]) -> None:
        self.url = url
        self.name = name
        self.tags = tags

    # issue with 'type hinting for static method' (until python 3.10)
    # see https://stackoverflow.com/questions/67522076/python-how-to-type-hint-a-class-argument-in-a-static-method-python
    # see https://stackoverflow.com/questions/61544854/from-future-import-annotations
    # see https://www.python.org/dev/peps/pep-0563/
    @staticmethod
    def load(raw: str):
        obj = yaml.safe_load(raw)
        return Bookmark(
            url=obj['url'],
            name=obj['name'],
            tags=obj['tags'],
        )

    def dump(self) -> str:
        return yaml.dump(self, default_flow_style=False)

    def __str__(self) -> str:
        return f'Bookmark(url={self.url}, name={self.name}, tags={self.tags})'

    def __repr__(self) -> str:
        return str(self)

    def match_any(self, tags: typing.List[str]) -> bool:
        for t in tags:
            if t in self.tags:
                return True
        return False

    def match_every(self, tags: typing.List[str]) -> bool:
        for t in tags:
            if t not in self.tags:
                return False
        return True


def get_bookmarks_paths_all(bookmarks_directory: str) -> typing.List[str]:
    os.chdir(bookmarks_directory)
    return [
        path
        for path
        in subprocess.check_output(['fd', '--type', 'file', '--extension', 'yaml', '--extension', 'yml']).decode().split('\n')
        if os.path.isfile(path)
    ]


def get_tags_all(bookmarks_directory: str) -> typing.List[str]:
    return list({
        j
        for i
        in get_bookmarks_paths_all(bookmarks_directory)
        for j in Bookmark.load(Helper.readfile(i)).tags
    })


def filter_by_tags_any(bookmark_file_paths: typing.List[str], tags: typing.List[str]) -> typing.List[str]:
    return [
        i
        for i in bookmark_file_paths
        if Bookmark.load(Helper.readfile(i)).match_any(tags)
    ]


def filter_by_tags_every(bookmark_file_paths: typing.List[str], tags: typing.List[str]) -> typing.List[str]:
    return [
        i
        for i in bookmark_file_paths
        if Bookmark.load(Helper.readfile(i)).match_every(tags)
    ]


def select_tags(all_tags: typing.List[str]) -> typing.List[str]:
    tmpf = tempfile.NamedTemporaryFile(
        prefix='/tmp/spinach-bookmarks-selector', mode='w+')
    tags_stream = '\\n'.join(all_tags)
    cmd = rf'''
        echo -n -e {tags_stream} \
        | fzf --multi \
        > {tmpf.name}
        '''
    subprocess.run(['alacritty', '-e', 'fish', '-c', cmd])
    tmpf.seek(0)
    selected = [
        i
        for i
        in tmpf.read().split('\n')
        if i in all_tags
    ]
    tmpf.close()

    Helper.log('selected-tags', selected)
    return selected


def select_bookmark(bookmark_file_paths: typing.List[str]) -> typing.Union[Bookmark, None]:
    tmpf = tempfile.NamedTemporaryFile(
        prefix='/tmp/spinach-bookmarks-selector', mode='w+')
    bm_files_stream = '\\n'.join(bookmark_file_paths)
    cmd = rf'''
        echo -n -e {bm_files_stream} \
        | fzf \
            --preview \
                'bat {{}} \
                    --language yaml \
                    --color always \
                    --paging never \
                    --line-range :500 \
                ' \
        > {tmpf.name}
        '''
    subprocess.run(['alacritty', '-e', 'fish', '-c', cmd])
    tmpf.seek(0)
    bmfile = tmpf.read().strip()
    tmpf.close()

    selected = None
    if os.path.isfile(bmfile):
        selected = Bookmark.load(Helper.readfile(bmfile))
    Helper.log('selected-bookmark', selected)
    return selected


if __name__ == '__main__':
    parser = argparse.ArgumentParser(
        description='spinach bookmarks manager for qutebrowser')
    parser.add_argument('--tab', action='store_true', dest='tab')
    parser.add_argument('--window', action='store_true', dest='win')
    parser.add_argument('--tags-match-any',
                        action='store_true', dest='tag_any')
    parser.add_argument('--tags-match-every',
                        action='store_true', dest='tag_every')

    args = parser.parse_args(sys.argv[1:])
    qute = Qute()
    Helper.log('args', args)

    bmdir = os.path.join(qute.config_dir, 'spinach-bookmarks')
    os.chdir(bmdir)
    bms = get_bookmarks_paths_all(bmdir)
    tags = get_tags_all(bmdir)
    Helper.log('bookmarks-directory', bmdir)
    Helper.log('bookmarks', bms)
    Helper.log('tags', tags)

    Helper.chain(
        funcs=[
            lambda bms: filter_by_tags_any(
                bms, select_tags(tags)) if args.tag_any else bms,
            lambda bms: filter_by_tags_every(
                bms, select_tags(tags)) if args.tag_every else bms,
            select_bookmark,
            lambda bm: qute.open_url(
                bm.url, new_window=args.win, new_tab=args.tab)
        ],
        start=bms
    )()