from typing import List
import vim
import os
import sys
import traceback

def py_log(*args,**kwargs) -> None:
    print('[spinach plugin-config loader: INFO]', *args, **kwargs, file=sys.stdout)
def py_err(*args,**kwargs) -> None:
    print('[spinach plugin-config loader: ERR]', *args, **kwargs, file=sys.stderr)

def load_plugin_configs(black_list: List[str]=[]) -> None:
    py_log('start loading plugin configurations')
    conf_dir = os.path.expandvars(r'$HOME/.config/nvim/plugin_config')
    loading = ''
    try:
        confs = sorted(os.listdir(conf_dir))
        for x in filter(lambda x:x not in black_list, confs):
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