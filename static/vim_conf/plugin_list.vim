call plug#begin('~/.local/share/nvim/plugins')

":: plugins for language support
Plug 'neoclide/coc.nvim', {'branch': 'release'}

":: plugins for user interface
Plug 'morhetz/gruvbox'
Plug 'ryanoasis/vim-devicons'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'mhinz/vim-startify'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'liuchengxu/vista.vim'
Plug 'skywind3000/vim-quickui'

":: uncategorized plugins
Plug 'kien/rainbow_parentheses.vim'
Plug 'preservim/nerdcommenter'
Plug 'easymotion/vim-easymotion'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'xuhdev/vim-latex-live-preview'


call plug#end()





"load plugin configuration files with python
python3 << PY_END

import vim
import os
def py_log(log):
	vim.command(f"echo '[PLUG_LOADER] {log}'")

def load_plugin_config():
	conf_dir=os.path.expandvars(r'$HOME/.config/nvim/plugin_config')
	loading = None
	try:
		confs = sorted(os.listdir(conf_dir))
		for x in confs:
			path = os.path.join(conf_dir,x)
			loading = path
			vim.command('source {}'.format(path))
			loading = None
	except Exception as e:
		py_log('FAILED:: {}'.format(loading))
		py_log('FAILED:: {}'.format(str(e)))
	else:
		py_log('SUCCESS:: all plugin config files loaded')

load_plugin_config()

PY_END
