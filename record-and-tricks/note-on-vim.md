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

- `vim-plug` 插件管理器
- `nerdtree` 文件树浏览.当然有了`fzf+ranger`就可扔掉它了
- `nerdcommenter` 快速注释/反注释
- `vim-airline` 状态栏
- `tabular`
- `fzf.vim`
- `ranger.vim`
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

参考官方文档即可,先要安装一些基础组建`coc-vimlsp`,`coc-syntax`,'coc-highligt',再来安装各种language server的client.  
使用`coc-marketplace`来快速查找插件.



