#!/usr/bin/python
import os
import sys
import traceback

import yaml

from spinach_fzf_menu import EntryPath, Helper, MenuEntry, MenuParser, main


def load():
    menu_file = os.path.expanduser('~/.config/i3/sysmenu.yml')
    doc = yaml.safe_load(Helper.readfile(menu_file))
    root = MenuParser.from_object(doc)
    return root


def preview(path: EntryPath, entry: MenuEntry) -> str:
    res = ''
    if entry.is_inner():
        res += 'GROUP'
    else:
        res += f'ACTION({entry.get_action().cmd})'
    res += '\n'.join([
        '',
        f'\tat-path\t={path}',
        f'\tkey\t={entry.key}',
        f'\tdesc\t={entry.desc}',
    ])
    return res


if __name__ == '__main__':
    try:
        main(sys.argv, load, preview,
             log_file='/tmp/spinach_sysmenu.log',
             prompt='sysctrl> ')
    except:
        Helper.err('exception', traceback.format_exc())
