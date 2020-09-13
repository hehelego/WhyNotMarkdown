## installed software

### 通用跨平台软件
* firefox
* SageMath
* LibreOffice
* VLC
* ffmpeg
* 7zip(gui frontend:ark,gnome archive manager)
* telegram
* v2ray(`sudo pacman -S v2ray qv2ray`)
* git
* vim/neovim(+vim-plug,**coc.nvim**,vim-airline,nerdtree,nerdcommenter)
* GNU toolchain(gcc,g++,gdb,make...) (via `sudo pacman -S base-devel`,`sudo pacman -S gdb`)
* python(with pip,~~virtualenv~~ pipenv)
* rustup
* stack(for haskell toolchain)
* texlive
* typora(opensource alternatives: vnote,marktext)
* pandoc
* virtualbox
* aria2
* qBittorrent
* motrix(download manager)
* persepolis(aria2 gui frontend)
* syncthing
* etcher
* graphviz
* scrcpy
* docker



### linux
> preferred distro:manjaro  
> desktop environment:kde  

* pacman
* yay(for aur)
* **timeshift**
* alacritty(a better terminal emulator)
* konsole
* gedit+kate
* gtkhash
* tmux
* fish
* fzf
* ranger
* krunner(or albert)
* filelight(or ncdu)
* fcitx5(with rime,rime-luna-pinyin)
* baloo(kde file indexing and searching service)
* `the_silver_search/ag`(a code-searching tool)
* nmtui(network manager TUI)
* screenkey+simplescreenrecorder+kdenlive
* kolourpaint(alternative to mspaint)
* wine(主要是为了使用QQ,Wechat**wine和virtualbox的体验没法比,如果性能足够,还是使用虚拟机**)
* tlp(tlp,tlp-rdw) (use tlpui for GUI frontend) (manjaro用户不必手动配置这些东西)
* cpu-x(for hardware infomation and benchmark)




### 小工具
* BILIdrive+CDNdrive
  * [cdn drive-pypi](https://pypi.org/project/CDNDrive/) [cdn drive-git](https://github.com/apachecn/CDNDrive)
  * [bili drive-pypi](https://pypi.org/project/BiliDriveEx/) [bili drive-git](https://github.com/apachecn/BiliDriveEx)
  * [ORIGIN-pypi](https://pypi.org/project/BiliDrive/) [ORIGIN-git](https://github.com/Hsury/BiliDrive)
* YouGet(pip install you-get) [youget.git](https://github.com/soimort/you-get)
* coursera-dl(pip install coursera-dl) [courseradl.git](https://github.com/coursera-dl/coursera-dl)
* ipython notebook(pip install ipython)
* rich(pip install rich) [rich.git](https://github.com/willmcgugan/rich)
* md2pdf\_helper.py (自己写的非常小的脚本,在`github/hehelego/whynotmarkdown/script`中,把它放到`~/.local/bin`里面就可以随处使用了)

### 浏览器插件
* charset(automatically detect&change encoding of a page)
* Tampermonkey
* OneTab
* Cookie Quick Manager(on firefox)
* Firefox(Print Edit We+Save Page We) / chrome(CtrlP print to PDF)






## tips(on Linux)
> distro:manjaro  
> de:kde  
> shell:fish
> terminal-theme:gruvbox

- 多看arch wiki/manjaro wiki,多去forum找找解决方案. 网速不够可以试试tuna/sjtug/ustc/aliyun/huawei mirror,以及github/gitlab难以访问时尝试gitee(码云).
- 虽然linux distro和windows不一样,不用经常reboot,但是reboot还是一个能解决不少问题的方法...当然有时候logout一下再回来,重启一下DE/WM就好了..
- manjaro是滚动发行版,可能出现新问题,旧问题可能被消除,解决方案可能会失效,尽量自己找第一手信息.
- manjaro特色之一: mhwd,有`mhwd-tui,mhwd`分别对应TUI和CLI,可以轻松配置driver,kernel.
- 换中国境内的软件源`sudo pacman-mirrors -i -c China -m rank`,也可以和arch一样直接编辑`/etc/pacman.conf /etc/pacman.d/mirrorlist`全球镜像列表自行去manjaro/arch官网找.
- [ban掉烦人的beep](https://wiki.archlinux.org/index.php/PC_speaker):在`/etc/modprobe.d/nobeep.conf`写入`blacklist pcspkr`之后reboot即可.
- ==(输入法看这里)==推荐使用fcitx5框架,rime输入法,luna-pinyin. 参考[archwiki:fcitx5](https://wiki.archlinux.org/index.php/Fcitx5)进行安装,配置即可.  
  使用rime时可以按`<F4>`快速进行配置(简体繁体转化,全角半角转换等).
- 使用wine,参考[arch wiki:wine](https://wiki.archlinux.org/index.php/Wine)
	- 安装`wine wine-mono wine-gecko winetricks`.
	- 使用`WINEPREFIX=${path-to-container} WINEARCH={win32,win64} command`指定容器位置和wine运行时架构,默认是`WINEPREFIX~/.wine WINEARCH=win64`.
	- 使用`wine a-program-built-for-windows.exe`来运行windows应用.
	- 使用`winecfg`和`wine regedit`(如上配合环境变量设置)对wine进行设置,以及调整注册表.
	- 需要先做个字体替换才能正常玩
	- 出现 框框字 问号字 古文字 等等...是字体读取的问题,在命令前面加入`env LC_ALL=zh_CN.gbk / env LC_ALL=zh_CN.UTF-8`即可.
- 关于wine qq/wechat/tim不能查看图片(2020.7.16)
  - ipv6有一点问题,导致连不上腾讯的图片cdn,需要做一个本机的http proxy.
  - 安装`privoxy`,之后`systemctl enable,start`启动服务(manjaro的init是systemd,不是用systemd的话略有区别).
  - qq/wechat/tim登陆的时候配置http代理.默认是`http://127.0.0.1:8118`
  - 有其他问题,自行查阅`man privoxy`查找对应的配置文件进行修改...
  - 请自行找`/etc/privoxy/config`里面的内容过滤,搜素`toggle`把它们都关掉.
  - 还不行的话只能暂时禁用ipv6...或者virtualbox装个windows虚拟机跑了.
- ==(DE/WM字体配置看这里)==需要调整fontconfig,locale,参考arch wiki.也可以在DE的`system settings`中直接设置.  
  **对于manjaro-kde用户而言,可以不用任何配置直接使用;CJK fonts fallback需要手动设置一下,让SC优先级高于JP即可(参考arch wiki)**  
- 字体配置推荐,无脑`Noto Sans CJK Sc`即可,个人体验来讲`Noto Sans`比`Source Sans`好一些,`Serif`字体不太习惯.对于等宽的编程字体,推荐`Source Code Pro`和`Liberation Mono`.具体而言`noto-fonts,noto-fonts-{cjk,emoji,extra,compat}`
- 使用arch的官方源安装texlive之后使用不了tlmgr管理CTAN包,这是个官方软件源bug,按照arch wiki上面[Texlive-tlmgr](https://wiki.archlinux.org/index.php/TeX_Live#tlmgr)修改配置即可,记得让tlmgr使用国内的CTAN镜像.  
  **这里最好直接去tuna mirrors上面找texlive的最新版本iso来安装.** 使用GUI installer需要`perl-tk`.把`add symbolic link`勾选上,这样就不用修改path了,正常让它安装完了就能使用了,不用再配置PATH之类的环境变量了.  
- KDE中`display>scaling`缩放,如果不是整数倍则会有bug.屏幕上可能会无端出现一根白线,并且icon及font的渲染都会有问题.
- 选择困难症?不妨看看[arch wiki:general recommendation](),[arch wiki:List of applications/Utilities]()
- 关于fish shell的一些事情
  - fish shell有些配置是不兼容bash的,比如path,manpath之类的,他的配置文件是`~/.config/fish/config.fish`配置的语法也和bash不同...尽量不要用`set -U VAR, set -g VAR`这种会影响全局配置甚至其他shell的配置.
  - bash中的`pacman -S $(cat softwarelist)`在fish中是`pacman -S (cat softwarelist)`.更常见的例子:`rm $(fzf -m)`应替换为`rm (fzf -m)`.
  - 中fish中一些regex的语法和fish shell的语法有冲突,使用单引号来标识他们,比如查询以rc结尾的配置文件应该这么写`ls ~/.config/ | grep 'rc$'`.
- 关于vim的一些事情(推荐同时安装vim,neovim;vim zero configuration替代nano做为default text editor,而neovim打造集成开发环境)
  - 插件管理器推荐`vim-plug`在github可以找到它.
  - `:termial`分屏出一个终端;`:set cursorcolumn,:set cursorline`提示光标所在col,row;
  - 通过`set guicursor`来设置光标情况,推荐无脑全用block.
  - 推荐插件:`nerdtree`,`nerdcommenter`,`indentLine`,`vim-airline`,`vim-startify`,`coc.nvim`
- 关于pandoc+xelatex下的`markdown+latex -> tex -> pdf`工作流.
  - 需要修改pandoc的转换模板,使得`markdown->tex`时具有正常的文档结构和设定的常用包以及字体配置.
  - 推荐使用[link:Eisvogel](https://github.com/Wandmalfarbe/pandoc-latex-template)这个LaTeX模板.参考他们的readme就可以正常使用了(参考命令`pandoc note.md -o book.pdf  --template eisvogel --listings --pdf-engine=xelatex`).我把我定制的eisvogel模板,以及编译脚本都放到了staic目录下面
  - 这里因为`tex->pdf`是LaTeX提供的,所以比mathjax的语法要求要强一些,版本升级会产生语法不向后兼容的问题,请自行查找资料或询问网友.
  - 字体配置比较麻烦,参考arch wiki中关于texlive的帮助页,自行将texlive安装时带有的字体加入系统的字体中.
  - 我自己用的转换脚本,模板文件都装`github/hehelego/whynotmarkdown`里面有.
- how to show installed AUR packages? `pacman -Qm / pacman -Q --foreign`,原理如下.  

> Restrict or filter output to packages that were not found in the sync database(s). Typically these are packages that were downloaded manually and installed
with --upgrade.

- 比较新的gdb中加入了`layout src`,`highlighting`,`struct pretty print`等features,使用更加便捷了,此外还有cgdb这个前端,更加方便易用.
- [v2ray proxy配置](https://qv2ray.net/),[github:qv2ray](https://github.com/Qv2ray/Qv2ray),[github:qv2ray-docs](https://github.com/Qv2ray/qv2ray.github.io)几乎是无脑配置. 代理路线推荐`JustMySocks`,国内有人做镜像/反响代理站可以正常访问,而且支持`Alipay(支付宝)`付款.




## LaTeX FAQ
- 如何换行:直接使用`\\`是无法换行的,需要一个aligned环境才可以用(在aligned环境中需要注意使用`&`来标识对齐位置以及对齐起点),当然,你也可以用equation环境(默认居中对齐,不允许自定义对齐),如果不想要equation环境的自动编号,则用`\begin{equation*} \end{equation*}`代替.
- 如何使用多行下标:使用`\begin{subarray}{l/r/c} \end{subarray}`创建多行下标的环境,参数标识左/右对齐或者居中(在这个环境中,不可以使用`&`来自定义对齐规则).
- 为啥我用`p \and q`不行啊? 现在用的是`\land`不少参考资料已经过时了,建议查较近时间段的文档.
- 关于不等号`\gt \lt`,它们已经被废弃了,现在可以直接用`> <`输入了,其他不等式关系符号基本上没有调整.
- 为啥我空了一行就行了/不行了? 建议学习latex语法...不要乱用空格和反斜线,以及换行(大概就是:使用`\\`必须在一个允许它的环境;不能直接空行;连续`\\`不会打出空行,要使用`\newline`命令).
- 使用`\pagebreak,\newpage`命令来换页,不让页面过于臃肿.
- mathjax的渲染效果和pdflatex,xelatex是有很大不同的...对语法的严格程度也有天壤之别.
- 编译为pdf的时候可能有`[WARNING] missing font for unicode character XXX`可以试试换其他代替符号,比如`\setminus <-> \backslash`当然这并不靠谱.**本人目前没有找到解决方案**


## using git

[git:official site](https://git-scm.com)  

> git is a **distributed version-control system** for tracking changes in source code during software development.  
> It is designed for coordinating work among programmers, but it can be used to track changes in any set of files.  
> Its goals include **speed, data integrity, and support for distributed, non-linear workflows**.  
>   
> git is free and open-source software distributed under the terms of GPL v2.  
>
> -- from wikipedia:git

- git虽然是分布式版本控制系统,为大规模协作开发而诞生,但是集中式管理,个人开发中仍然可以用得上.
- git已经是实际上的行业标准(甚至有在IT之外的领域被广泛使用的趋势).
- 已经有不少vim plugin,shell plugin(比如我喜欢的fish shell)集成了git操作.也有不少TUI,GUI的git client,还有gitlab,gitea,github等webapp提供便利操作.

### git的概念与设计
- git的分布式管理从实践来看,是比svn的集中式管理更优秀的.
  - 不需要一个统一管理的中心服务器,可以轻松离线工作,轻松多人协同,不用每次都联网进行pull,update,push还要解决冲突.
  - 在git中,每个人本地都有完整的版本仓库,把自己做的修改同步给其他人就可以完成协作(当然还需要解决不同修改的冲突).
  - 为了方便,也可以建立一个中心服务器,不用搭建p2p网络,方便交换数据,比如程序员喜闻乐见的github与gitlab以及国内的gitee都是这种平台.
- git除了分布式无需中心,方便离线工作的特点,最重要的特性是分支管理,这也是它取代svn的重要原因.
- 每个版本独立保存(方便了分支管理).
- 维护`working directory`,`stage `,`repository`(工作区,暂存区,仓库).
  - 直接操作working dir,此时是隔离其他版本与分支的.
  - 将改动(插入,删除,修改,移动...)的文件加入stage.
  - 将stage中的文件,提交到repo.存放所有版本.
- 文件状态
  - modified
  - staged
  - committed

### git常规操作.
在一切使用之前,要做基本的配置.
```bash
#使用--global flag则会修改`~/.gitconfig`,否则修改当前repo的`.git/.config`
git config --global user.name $USER_NAME
git config --global user.email $USER_EMAIL

git config --list #查看已有配置
```
- git clone:把远程repo下载到本地,可以用https或者git协议(一般而言这笔直接用http传输文件快很多).
- git init:在当前目录创建`.git/`初始化git repo
- git add:把working dir的修改加入stage中,可以指定要加入的文件,也可以`git add -A`
- git checkout:用stage替代working dir(**危险**操作,谨慎使用)
- git reset:撤销commit.使用`git reset HEAD`(**危险**操作,谨慎使用),如果是`--hard`则会影响working dir.
- git commit:把stage提交到repo,使用`git commmit -m "message"`可以附带一个提交说明.(会给出这个commit的全局唯一id,由于是多人协作的,所以需要搞一个全局唯一id标识提交)一个commit就是一个版本.
- git status:它会返回 当前所在brach,working dir中尚未加入stage的修改(untracked),stage中未提交的修改.
- git log:查看提交记录
- git diff:版本比较.



## stared repositories

[github stars:hehelego](https://github.com/hehelego?tab=stars)
