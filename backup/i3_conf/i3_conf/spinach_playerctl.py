#!/usr/bin/python
import subprocess
import sys

from spinach_fzf_menu import EntryPath, MenuEntry, MenuParser, main


if __name__ == '__main__':
    def load():
        players = subprocess.getoutput('playerctl --list-all').split('\n')
        if players[0] == 'No players found':
            players = []

        show = {
            'show': {
                'desc': 'show the information of certain player',
                'son': [
                    {i: {'desc': f'media player:{i}', 'action': ''}}
                    for i in players
                ]
            }
        }
        play = {
            'play': {
                'desc': 'continue playing',
                'son': [
                    {i: {'desc': f'media player:{i}',
                         'action': f'playerctl --player="{i}" play'}}
                    for i in players
                ]
            }
        }
        pause = {
            'pause': {
                'desc': 'pause playing',
                'son': [
                    {i: {'desc': f'media player:{i}',
                         'action': f'playerctl --player="{i}" pause'}}
                    for i in players
                ]
            }
        }
        stop = {
            'stop': {
                'desc': 'stop playing',
                'son': [
                    {i: {'desc': f'media player:{i}',
                         'action': f'playerctl --player="{i}" stop'}}
                    for i in players
                ]
            }
        }
        all_player = {
            'all': {
                'desc': 'control all the players at once',
                'son': [
                    {'play': {'desc': 'continue playing',
                              'action': 'playerctl --all-players play'}},
                    {'pause': {'desc': 'continue playing',
                               'action': 'playerctl --all-players pause'}},
                    {'stop': {'desc': 'continue playing',
                              'action': 'playerctl --all-players stop'}},
                ]
            }
        }

        doc = {
            'playerctl': {
                'desc': 'media player control',
                'son': [
                    show,
                    play,
                    pause,
                    stop,
                    all_player
                ]
            }
        }

        return MenuParser.from_object(doc)

    def preview(path: EntryPath, entry: MenuEntry) -> str:
        if entry.is_leaf() and 'all' not in path.as_list():
            return subprocess.getoutput(f'playerctl --player="{entry.key}" metadata')
        else:
            return entry.desc

    main(sys.argv, load, preview, '/tmp/spinach_playerctl.log')
