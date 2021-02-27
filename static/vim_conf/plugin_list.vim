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



source $HOME/.config/nvim/plugin_config/coc.vim
source $HOME/.config/nvim/plugin_config/nerdcommenter.vim
source $HOME/.config/nvim/plugin_config/easymotion.vim
source $HOME/.config/nvim/plugin_config/gruvbox.vim
source $HOME/.config/nvim/plugin_config/rainbow_parentheses.vim

