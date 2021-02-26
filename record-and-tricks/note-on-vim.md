# note on vim

> vim: I'd like to keep a zero-configuration minimal editor.
> neovim: I'd like to have a fully-customized,user-friendly IDE
> vimpager: `PAGER=vimpager man vim`
> spacevim: ALL IN ONE "a community driven vim distribution" (similar to SpaceEmacs)  ~~懒人必备~~


## resources

- man pages; tldr pages.
- [neovim user manual](https://neovim.io/doc/user/)
- github/awesomevim,[vimawesome.com](https://vimawesome.com/)
- [spaceVim](https://spacevim.org/)
- [a byte of vim](https://github.com/swaroopch/byte-of-vim): a nice short tutorial for beginner, slightly outdated
- [learn vim the smart way](https://github.com/iggredible/Learn-Vim)
- [vim galore](https://github.com/mhinz/vim-galore)
- vimnium: a browser extension(or plugin). available in firefox and chrome
- alacritty vim mode: `ctrl+shift+space` to start vim mode, `i` back to nromal mode.


## tricks

- terminal: 在vim/neovim中有所不同.在neovim中有`terminal mode`使用`(ctrl+\)+(ctrl+n)`来返回`normal mode`
- run `nvim -L` or `vim -L` to show the `.swp` swapfiles. 
- vim在文件末尾会现实很多行`~`,可以参考[stack overflow: disabling tildes](https://stackoverflow.com/questions/3813059/is-it-possible-to-not-display-a-for-blank-lines-in-vim-neovim)操作.  
  在vimrc中加入`set fillchars=fold:\ ,vert:\│,eob:\ ,msgsep:‾`,改变最后填充的字符.


## plugins

- `vim-plug` 插件管理器
- `vim-startify` 更好的启动界面
- `vim-airline` 状态栏
- `vim-easy-align` 快速对齐
- `vim-tabular` 快速对齐
- `fzf.vim` 把fzf集成入vim,提供了`:Files,:Ag,:Rg`分别对应fzf,the silver search,ripgrep还有一大堆工具的集成.  
- `ranger.vim` 把ranger集成入vim
- `markdown-preview.nvim` 
- `latex live preview`
- `undotree` 可视化文件内容变动记录
- `suda.vim` 不必再使用sudo启动vim,把sudo集成到vim中.
- `coc.nvim` COC插件体系,用于LSP支持.


## backup

`$(REPO_ROOT)/static/vim_conf`
