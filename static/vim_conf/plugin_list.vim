call plug#begin('~/.local/share/nvim/plugins')

":: plugins for language support
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'liuchengxu/vista.vim'

":: plugins for user interface
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'mhinz/vim-startify'
Plug 'ryanoasis/vim-devicons'
Plug 'morhetz/gruvbox'

":: uncategorized plugins
Plug 'kien/rainbow_parentheses.vim'
Plug 'preservim/nerdcommenter'
Plug 'easymotion/vim-easymotion'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'xuhdev/vim-latex-live-preview'


call plug#end()





" load plugin configuration files with python
python3 << PY_END

import vim
import os

def py_log(msg):
	vim.command(r"echo '[hehelego] {}'".format(msg))

def load_plugin_config():
	py_log('loading plugin configurations')
	conf_dir=os.path.expandvars(r'$HOME/.config/nvim/plugin_config')
	try:
		confs = os.listdir(conf_dir)
		for i in confs:
			py_log('loading {}'.format(i))
			path = os.path.join(conf_dir,i)
			vim.command('source {}'.format(path))
	except Exception as e:
		py_log('FAILED:: {}'.format(str(e)))
	else:
		py_log('SUCCESS:: all plugin config files loaded')


load_plugin_config()

PY_END
