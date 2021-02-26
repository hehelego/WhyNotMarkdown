call plug#begin('~/.local/share/nvim/plugins')

Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'preservim/nerdcommenter'

Plug 'easymotion/vim-easymotion'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'mhinz/vim-startify'
Plug 'ryanoasis/vim-devicons'
Plug 'morhetz/gruvbox'

call plug#end()



source $HOME/.config/nvim/plugin_config/coc.vim
source $HOME/.config/nvim/plugin_config/nerdcommenter.vim
source $HOME/.config/nvim/plugin_config/easymotion.vim
source $HOME/.config/nvim/plugin_config/gruvbox.vim

