" basic configurations
" :: tabstop, mapleaders, termguicolors ... 
source $HOME/.config/nvim/basic.vim

" :: load plugins
source $HOME/.config/nvim/plugins.vim
" load plugin configuration files with python
py3file $HOME/.config/nvim/load_plugin_conf.py

" :: more custom keymappings
py3file $HOME/.config/nvim/load_keymap.py

" :: miscellaneous settings
source $HOME/.config/nvim/MISC.vim
