#!/usr/bin/python
import subprocess
import sys
import traceback
from typing import Callable, Union

from spinach_fzf_menu import EntryPath, Helper, MenuEntry, MenuParser, main


PlayerList = list[str]
ActionEntry = dict[str, dict[str, str]]
ActionList = list[ActionEntry]
EntryGenerator = Callable[[PlayerList], dict[str, Union[str, ActionList]]]


def create_eg(desc: str, cmd: str) -> EntryGenerator:
    def wrapper(players: PlayerList) -> dict[str, Union[str, ActionList]]:
        return {
            'desc': desc,
            'son': [
                {i: {
                    'desc': f'{desc} for player {i}',
                    'action': f'playerctl --player="{i}" {cmd}',
                }}
                for i in players
            ]
        }
    return wrapper


def load():
    players = subprocess.getoutput('playerctl --list-all').split('\n')
    if players[0] == 'No players found':
        players = []

    entry_gens: dict[str, EntryGenerator] = {
        'status': create_eg('show the status', 'status'),
        'metadata': create_eg('show the metadata', 'metadata'),
        'play': create_eg('continue playing', 'play'),
        'pause': create_eg('pause playing', 'pause'),
        'stop': create_eg('pause playing', 'stop'),
        'toggle-play': create_eg('toggle playing status', 'play-pause'),
        'previous': create_eg('play the previous file', 'previous'),
        'next': create_eg('play the next file', 'next'),
        'shuffle-on': create_eg('turn on playlist shuffling', 'shuffle On'),
        'shuffle-off': create_eg('turn off playlist shuffling', 'shuffle On'),
        'toggle-shuffle': create_eg('toggle playlist shuffling', 'shuffle On'),
        'loop-off': create_eg('disable looping', 'loop None'),
        'loop-track': create_eg('loop on the current track', 'loop Track'),
        'loop-playlist': create_eg('loop on the playlist', 'loop Playlist'),
    }
    all_at_once = {
        'all': {
            'desc': 'control all the players at once',
            'son': [
                {'play': {'desc': 'continue playing',
                          'action': 'playerctl --all-players play'}},
                {'pause': {'desc': 'continue playing',
                           'action': 'playerctl --all-players pause'}},
                {'toggle-play': {'desc': 'toggle play/pause',
                                 'action': 'playerctl --all-players play-pause'}},
                {'stop': {'desc': 'continue playing',
                          'action': 'playerctl --all-players stop'}},
            ]
        }
    }
    single_at_once = {
        'single': {
            'desc': 'control one the player at once',
            'son': [
                {key: gen(players)}
                for (key, gen) in entry_gens.items()
            ]
        }
    }

    doc = {
        'playerctl': {
            'desc': 'media player control',
            'son': [
                all_at_once,
                single_at_once,
            ]
        }
    }

    return MenuParser.from_object(doc)


def preview(path: EntryPath, entry: MenuEntry) -> str:
    if entry.is_leaf() and 'all' not in path.as_list():
        metadata = subprocess.getoutput(f'playerctl --player="{entry.key}" metadata')
        status = subprocess.getoutput(f'playerctl --player="{entry.key}" status')
        return f'{status}\n\n{metadata}'
    else:
        return entry.desc


if __name__ == '__main__':
    try:
        main(sys.argv, load, preview, 
             log_file='/tmp/spinach_playerctl.log',
             prompt='playerctl> ')
    except:
        Helper.err('exception', traceback.format_exc())
