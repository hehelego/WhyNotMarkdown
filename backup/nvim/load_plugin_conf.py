import os
import sys
import traceback
from typing import Any

import vim


def notify_send(msg: Any, level: str, expire_time: int) -> None:
    import subprocess
    try:
        subprocess.run(['notify-send',
                        '-u', level,
                        '-t', str(expire_time),
                        f'[vim: spinach] {msg}'],
                       timeout=0.1)
    except:
        print("oh fuck")


def py_log(msg): return notify_send(msg, 'low', 1000)
def py_err(msg): return notify_send(msg, 'critical', 5000)


def load_plugin_configs(black_list: list[str] = []) -> None:
    py_log('start loading plugin configurations')
    conf_dir = os.path.expandvars(r'$HOME/.config/nvim/plugin_config')
    loading = ''
    try:
        confs = sorted(os.listdir(conf_dir))
        for x in filter(lambda x: x not in black_list, confs):
            loading = path = os.path.join(conf_dir, x)
            if path.endswith('.vim'):
                vim.command(f'source {path}')
            elif path.endswith('.py'):
                vim.command(f'py3file {path}')
            elif path.endswith('.lua'):
                vim.command(f'luafile {path}')
            else:
                py_err(f'unknown plug-conf {path}')
    except Exception:
        py_err(f'failed {loading}')
        traceback.print_exc(file=sys.stderr)
    else:
        py_log('all plugin configs loaded')


if __name__ == '__main__':
    load_plugin_configs()
