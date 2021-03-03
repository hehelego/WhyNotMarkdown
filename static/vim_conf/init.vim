source $HOME/.config/nvim/plugin_list.vim


set guicursor=n-v-c-sm:block,i-ci-ve:block,r-cr-o:block
set encoding=utf-8
set tabstop=2
set shiftwidth=2
set timeoutlen=500
set updatetime=500
set hidden
set nobackup
set nowritebackup
set cmdheight=1
set shortmess+=c
let mapleader=" "
set number
set relativenumber

set termguicolors
colorscheme gruvbox
highlight Normal guibg=NONE ctermbg=NONE

map <Leader>h :<C-u>echo 'hello'<CR>
map <C-S-l> :<C-u>nohlsearch<CR>
