#!/usr/bin/python

# see https://github.com/alphapapa/solarized-everything-css
# see https://gitlab.com/dwt1/dotfiles/-/blob/master/.config/qutebrowser/config.py
# see qute://help/settings.html#content.user_stylesheets

from spinach_qutepy import Fzf, Qute, Helper

import subprocess
import os
import typing


def get_themes(themes_dir: str, search: str) -> typing.List[str]:
    os.chdir(themes_dir)
    themes = [
        path
        for path
        in subprocess.check_output(['fd', '--type', 'file', '--extension', 'css', search]).decode().split('\n')
        if os.path.isfile(path)
    ]
    Helper.log('all available themes', themes)
    return themes


def get_themes_all(themes_dir: str) -> typing.List[str]:
    return get_themes(themes_dir, 'all-sites')


def get_themes_full(themes_dir: str) -> typing.List[str]:
    return get_themes(themes_dir, '')


if __name__ == '__main__':
    qute = Qute()

    themes_dir = os.path.join(qute.config_dir, 'userstyles')
    os.chdir(themes_dir)
    themes = get_themes_all(themes_dir)
    selected = Fzf.fzf_select(themes, prompt='theme> ')
    if len(selected) > 0:
        qute.exec(f':set -tp content.user_stylesheets {os.path.join(themes_dir, selected[0])}')
    else:
        qute.exec(f':set -tp content.user_stylesheets \'\'')
