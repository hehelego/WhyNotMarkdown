# note on vim

> use vim+neovim  
> vim: zero-configuration,default CLI editor
> neovim: making it a fully-customized,user-friendly IDE
> 
> **don't share config/plugin/cache between them, or your enviroment would be destoryed**


## resources

- github: awesome vim
- [neovim user manual](https://neovim.io/doc/user/)
- a byte of vim
- vimium(vim-mode browser)

## config

- 通过`set guicursor`来设置光标情况,推荐无脑全用block.

## tricks

- register: (q{a-z},q,@{a-z},N@q{a-z})
- multi tabs tabnew/tabedit/tabclose/tabnext/tabprevious; vim -p
- split windows: (split/vertical split : sp/vsp, close/only); (resize/vertical resize : res/vert); Ctrl+W+hjkl;
- terminal:


## plugins

- 插件管理器推荐`vim-plug`在github可以找到它.
- `nerdtree`,当然有了`fzf.vim`就可扔掉它了
- `nerdcommenter`
- `vim-airline`
- `vim-startify`
- `tabular`
- `fzf.vim`
- `coc.nvim`
- `markdown-preview`
- `vim-latex`


## COC.nvim

> reference: [github: coc.nvim](https://github.com/neoclide/coc.nvim)

```shell
sudo pacman -S nodejs npm
sudo pacman -S python-pynvim
sudo npm install -g neovim
```
启动neovim,运行`:checkhealth`确认环境正常,可以安装coc.

在`~/.config/nvim/init.vim`的`plugin`中加入`coc.nvim`

