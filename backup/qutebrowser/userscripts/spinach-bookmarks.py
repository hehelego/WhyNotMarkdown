#!/usr/bin/python

import argparse
import os
import subprocess
import sys
import typing

import yaml

from spinach_qutepy import Fzf, Helper, Qute


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
        url, name, tags = obj['url'], obj['name'], obj['tags']
        assert(type(url)==str)
        assert(type(name)==str)
        assert(type(tags)==list)
        return Bookmark(url, name, tags)

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
    selected = Fzf.fzf_select(all_tags, multi=True, preview=None, prompt='bookmark tag> ')
    Helper.log('selected-tags', selected)
    return selected


def select_bookmark(bookmark_file_paths: typing.List[str]) -> typing.Union[Bookmark, None]:
    selected = Fzf.fzf_select(bookmark_file_paths, prompt='bookmark> ')
    Helper.log('selected-bookmark-file', selected)
    bmfile = selected[0] if len(selected) > 0 else ''
    if os.path.isfile(bmfile):
        bm = Bookmark.load(Helper.readfile(bmfile))
        Helper.log('selected-bookmark-entry', bm)
        return bm
    return None


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

    if args.tag_any:
        bms = filter_by_tags_any(bms, select_tags(tags))
    if args.tag_every:
        bms = filter_by_tags_every(bms, select_tags(tags))
    bm = select_bookmark(bms)
    if bm is not None:
        qute.open_url(bm.url, new_window=args.win, new_tab=args.tab)
