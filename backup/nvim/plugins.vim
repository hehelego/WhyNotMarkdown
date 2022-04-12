call plug#begin('~/.local/share/nvim/plugins')

" for LSP-client and CocList
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" for extra language settings
Plug 'sheerun/vim-polyglot'
" for rust-lang enchancement
Plug 'rust-lang/rust.vim'
" for extra colorschemes
Plug 'joshdick/onedark.vim'
Plug 'morhetz/gruvbox'
" for nerdfont file icon support
Plug 'ryanoasis/vim-devicons'
" for status-line and tab-line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" for a fancy start menu displaying recent accessed file
Plug 'mhinz/vim-startify'
" for FZF,ag,rg integration
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" for jumping between directories
Plug 'nanotee/zoxide.vim'
" for viewing symbol/tag tree
Plug 'liuchengxu/vista.vim'
" for running shell command asynchronously
Plug 'skywind3000/asynctasks.vim'
Plug 'skywind3000/asyncrun.vim'
" for git integration
Plug 'tpope/vim-fugitive'
" for viewing change history and back tracing
Plug 'mbbill/undotree'
" for colorizing pair parentheses
Plug 'luochen1990/rainbow'
" for quick commenting/uncommenting
Plug 'preservim/nerdcommenter'
" text alignment
Plug 'junegunn/vim-easy-align'
" for quick cursor navigating
Plug 'easymotion/vim-easymotion'
" for markdown/latex previewing 
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'xuhdev/vim-latex-live-preview'
" for whichkey keybindings map
Plug 'folke/which-key.nvim'

" for risc-v assembly syntax support
Plug 'henry-hsieh/riscv-asm-vim'
call plug#end()
