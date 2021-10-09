#!/usr/bin/python

# see https://github.com/alphapapa/solarized-everything-css
# see https://gitlab.com/dwt1/dotfiles/-/blob/master/.config/qutebrowser/config.py
# see qute://help/settings.html#content.user_stylesheets

from spinach_qute_userscript_base import Qute, Helper

import subprocess
import os
import tempfile
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
    return get_themes(themes_dir,'all-sites')
def get_themes_full(themes_dir: str) -> typing.List[str]:
    return get_themes(themes_dir,'')


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
    selected = os.path.join(
        themes_dir, selected) if selected is not None else '\'\''
    qute.exec(f':set -tp content.user_stylesheets {selected}')
