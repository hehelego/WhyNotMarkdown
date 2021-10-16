# note on vim

## resources

- man pages; tldr pages.
- [neovim user manual](https://neovim.io/doc/user/)
- github/awesomevim,[vimawesome.com](https://vimawesome.com/)
- [spaceVim](https://spacevim.org/)
- [lunarvim](https://www.lunarvim.org)
- [a byte of vim](https://github.com/swaroopch/byte-of-vim): a nice short tutorial for beginner, slightly outdated
- [learn vim the smart way](https://github.com/iggredible/Learn-Vim)
- [vim galore](https://github.com/mhinz/vim-galore)
- vimnium: a browser vim-mode extension/plugin. available in firefox and chrome
- alacritty vim-mode: `ctrl+shift+space`
- vimpager: use vim as a pager (replacing the default less pager)

## tricks

### modularized vimrc or init.vim

强行分离`init.vim`为多个`vimscript`, 在`init.vim`中使用source命令加载它们(注意顺序问题,相对路径问题)

### terminal mode

- `:terminal`
- `<C-\><C-n>`返回normal mode

### find all the .swp files

run `nvim -L` or `vim -L` to show the `.swp` swapfiles.

### display blank lines with tildes

- vim在文件末尾会现实很多行`~`,可以参考[stack overflow: disabling tildes](https://stackoverflow.com/questions/3813059/is-it-possible-to-not-display-a-for-blank-lines-in-vim-neovim)操作.
  1. 在neovim中可以直接修改填充字符 `set fillchars=fold:\ ,vert:\│,eob:\ ,msgsep:‾`
  2. 将EOF fillchar的颜色改为和背景一致 `highlight EndOfBuffer ctermfg=black ctermbg=black`
- vimrc启用了`termguicolor`,colorscheme设置transparent background,terminal emulator支持并启用transparent.无法得到真正透明效果.  
  可以强制修改背景`highlight Normal guibg=NONE ctermbg=NONE`

### listchars: visualize wihite space characters

- `:help listchars`

### performing pattern searching with unicode in vim

- [StackOverflow: regex unicode character in vim](https://stackoverflow.com/questions/3016965/regex-unicode-character-in-vim). 使用形如`\%u200b`的搜索式.

### generate a list of increasing integers

- see [irian's blog: generate and increment numbers](https://irian.to/blogs/quick-vim-tips-to-generate-and-increment-numbers)

use visual mode

```plaintext
i0<Escape>
yy9p
<C-v>
g8j
g<C-a>
```

```plaintext
i0<Escape>
yy9p
<C-v>
g8j
2g<C-x>
```

use `put`:

```vimscript
:put=range(3)
:put=range(1,5)
:put=range(10,0,-1)
```

## plugins

使用`vim-plug`或者`dein`管理插件.

### basic configuration

`polyglot.vim`, `sensible.vim`

### user interface

`fzf.vim`, `denite`, `coc-list`, `which-key.nvim`

### build system

`asyncrun.vim`, `asynctasks.vim`

### language support

目前解决方案是LSP(language server protocol), 分离语言环境和编辑器环境.

vim中的LSP的client: neovim native LSP client (since version 0.5), `coc.nvim`

`vista`, LSP symbol tree 和 ctags 插件

### misc

1. `markdown-preview.nvim` [link](https://github.com/iamcco/markdown-preview.nvim)
2. `latex-live-preview` [link](https://github.com/xuhdev/vim-latex-live-preview)
3. `fugitive`: git integration
4. `undotree`: edit history backtrace
5. `airline`: fancy status-line and tab-line
6. `nerdcommenter`: quick comment/uncomment code.
7. `rainbow_parentheses`: colorized parentheses matchings
8. `vim-easyalign`: creat tabular, quick code alignment.
9. `easymotion`: fuzzy find and navigate cursor.
10. `startify`: cow say + recent files + MRU manager

## backup

`$(REPO_ROOT)/backup/nvim/`
