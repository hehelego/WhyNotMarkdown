# note on vim

> I'd like to keep a zero-configuration minimal editor, the `/usr/bin/vim`
> I'd like to have a fully-customized,user-friendly IDE, the `/usr/bin/nvim`
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
- vimnium: a browser vim-mode extension/plugin. available in firefox and chrome
- alacritty vim-mode: `ctrl+shift+space`


## tricks

- **modularized vimrc**, the brute-force&naive approach: 强行分离`init.vim`为多个`vimscript`,在`init.vim`中使用source命令加载它们(注意顺序问题,相对路径问题)
- terminal: 在vim/neovim中有所不同.在neovim中有`terminal mode`使用`(ctrl+\)+(ctrl+n)`来返回`normal mode`
- run `nvim -L` or `vim -L` to show the `.swp` swapfiles. 
- vim在文件末尾会现实很多行`~`,可以参考[stack overflow: disabling tildes](https://stackoverflow.com/questions/3813059/is-it-possible-to-not-display-a-for-blank-lines-in-vim-neovim)操作.
  1. 在neovim中可以直接修改填充字符 `set fillchars=fold:\ ,vert:\│,eob:\ ,msgsep:‾`
	2. 将EOF fillchar的颜色改为和背景一致 `highlight EndOfBuffer ctermfg=black ctermbg=black`
  在vimrc中加入`set fillchars=fold:\ ,vert:\│,eob:\ ,msgsep:‾`,改变最后填充的字符.
- vimrc启用了`termguicolor`,colorscheme设置transparent background,terminal emulator支持并启用transparent.无法得到真正透明效果.  
  可以强制修改背景`highlight Normal guibg=NONE ctermbg=NONE`
- want to visualize whitespace characters? read `:help listchars`
- performing pattern searching with unicode in vim [StackOverflow: regex unicode character in vim](https://stackoverflow.com/questions/3016965/regex-unicode-character-in-vim). 使用形如`\%u200b`的搜索式.

## plugins

使用`vim-plug`或者`dein`管理插件.

- plugins for `basic configuration`
- plugins for `user interface`
- plugins for `build system`
- plugins for `language support`
  1. 目前解决方案是LSP(language server protocol),分离语言环境和编辑器环境.
	2. LSP的client: neovim 0.5中加入的native LSP client, `coc.nvim,vim-lsp,ale`等插件.
- MISC
	1. `markdown-preview.nvim` [link](https://github.com/iamcco/markdown-preview.nvim)
	2. `latex-live-preview` [link](https://github.com/xuhdev/vim-latex-live-preview)


## backup

`$(REPO_ROOT)/static/vim_conf`
