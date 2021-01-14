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

## config

- 通过`set guicursor`来设置光标情况,推荐无脑全用block.

## tricks

- register: (q{a-z},q,@{a-z},N@q{a-z})
- multi tabs tabnew/tabedit/tabclose/tabnext/tabprevious; vim -p
- split windows: (split/vertical split : sp/vsp, close/only); (resize/vertical resize : res/vert); Ctrl+w+hjkl;
- terminal: 在vim/neovim中有所不同.在neovim中有`terminal mode`使用`(ctrl+\)+(ctrl+n)`来返回`normal mode`
- ctrl+o: jump back to the previous file
- ctrl+d/ctrl+u: page down/page up
- search: `/regex`,`?regex` for forward/backward search,  `/regex\C,/regex\c` for case sensitive/insensitive. `*,#` to search forward/backward the word under cursor.
- ctrl+a/ctrl+x: increase/decrease the number under the cursor.
- when cursor on `{([`, press `%` to jump to the matched bracket.

> - use `vimnium` extension/plugin to enable vim-mode in a browser.  
> - use `ctrl+shift+space/i` to enter/escape vim-mode in alacritty(a fancy terminal emulator)

- run `nvim -L` or `vim -L` to show the `.swp` swapfiles. 


## plugins

- `vim-plug` 插件管理器
- `nerdtree` 文件树浏览.当然有了`fzf+ranger`就可扔掉它了
- `nerdcommenter` 快速注释/反注释
- `vim-startify` 更好的启动界面
- `vim-airline` 状态栏
- `vim-easy-align` 快速对齐
- `vim-tabular` 快速对齐
- `fzf.vim` 把fzf集成入vim,提供了`:Files,:Ag,:Rg`分别对应fzf,the silver search,ripgrep还有一大堆工具的集成.  
- `ranger.vim` 把ranger集成入vim
- `markdown-preview.nvim` full-featured real-time markdown preview plugin,命令是`:MarkdownPreview,:MarkdownPreviewStop`
- `undotree` 可视化文件内容变动记录
- `suda.vim` 不必再使用sudo启动vim,把sudo集成到vim中.
- `coc.nvim` COC插件体系,用于LSP支持.

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



