## installed software

### 通用跨平台软件
* firefox
* SageMath
* LibreOffice
* VLC
* ffmpeg
* gtkhash
* 7zip(gui frontend:ark,gnome archive manager)
* telegram
* v2ray+shadowsocks(for proxy)
* git
* vim/neovim(with vim-plug)
* GNU toolchain(gcc,g++,gdb,make...) (via `sudo pacman -S base-devel`,`sudo pacman -S gdb`)
* python(with pip,virtualenv)
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


### windows
* Avast antivirus
* huorong antivirus
* ccleaner
* treesize
* tim(QQ)+wechat
* cloudmusic(netease music)
* **msys2**(Gnu toolchain,git,ssh....轻量级的模拟linux环境)
* everything
* windows sandbox
* powershell
* github desktop
* OneDrive
* rufus
* .
* krkr2
* ONScripter
* LocaleEmulator
* Yuki([link](https://github.com/project-yuki/YUKI) alternative to VNR)
* AlphaROMdiE [link](http://azure.kdays.cn/onekeyunlock/)
* winCDemu

### linux
> preferred distro:manjaro  
> desktop environment:kde  

* pacman
* yay(for aur)
* alacritty(a better terminal emulator)
* konsole
* tmux
* fish
* fzf
* ranger
* krunner(or albert)
* filelight(or ncdu)
* fcitx5
* baloo(kde file indexing and searching service)
* `the_silver_search/ag`(a code-searching tool)
* nmtui(network manager TUI)
* screenkey+simplescreenrecorder+kdenlive
* wine(AUR:deepin-wine-qq,deepin-wine-wechat)
* Onedrive client([link](https://github.com/abraunegg/onedrive)可在在archlinuxcn repo中直接找到打包的二进制)





### 小工具
* BILIdrive+CDNdrive
  * [cdn drive-pypi](https://pypi.org/project/CDNDrive/) [cdn drive-git](https://github.com/apachecn/CDNDrive)
  * [bili drive-pypi](https://pypi.org/project/BiliDriveEx/) [bili drive-git](https://github.com/apachecn/BiliDriveEx)
  * [ORIGIN-pypi](https://pypi.org/project/BiliDrive/) [ORIGIN-git](https://github.com/Hsury/BiliDrive)
  * [youget.git](https://github.com/soimort/you-get)
* YouGet(pip install you-get)
* coursera-dl(pip install coursera-dl)
* ipython notebook
* [rich](https://github.com/willmcgugan/rich)

### 浏览器插件
* charset(automatically detect&change encoding of a page)
* Tampermonkey
* OneTab
* Cookie Quick Manager(on firefox)
* Firefox(Print Edit We+Save Page We) / chrome(CtrlP print to PDF)







## tips(on Windows10)
* **windows/linux上面的不少问题都可以 重启 解决**
* markdown:`[TOC]`建立可以生成token表,当目录用..
* git clone比http传输文件快很多,下载不成功的时候试试用git CLI进行clone吧
* python -m http.server创建临时http静态文件服务器.
* win+shift+s (screen shot)
* windows10更新出锅,一堆应用启动不了,能查到进程,但是UI显实不了/进入不了REPL,敲入命令后卡住.建议清空windows临时文件,可以everything手动查找临时文件(C:/Users/{UserName}/AppData/Local/Temp)删除,或者使用Ccleaner自动清空….如果仍然不行,可以重启explorer.exe(中文叫windows资源管理器)
* windows10更新出锅,启动后desktop不显示.建议(ctrl+alt+del,alt+T),召唤任务管理器,(alt+F+N)输入explorer,启动windows资源管理器(explorer.exe)…
* 上面的软件不少是open source的,并且有国内镜像,可以尝试到tuna(Thu建立),ustc mirror找找镜像,在GFW之内也能高速下载/更新.
* vim for windows中有些奇怪的map使得`Ctrl+V`无法进入`visual-block`模式(批量注释之类的功能),找到vim安装目录中的`mswin.vim`,注释掉这一行.

```vim
" CTRL-V and SHIFT-Insert are Paste
map <C-V> "+gP
```

- windows sandbox需要在`控制面板>程序与功能>启动关闭windows功能`中启动
  - hyper-V的全部功能
  - windows sandbox
  - windows 虚拟机监控程序平台
  - 用bcdedit让hyper-v自动启动.
  - hyper-v功能启动后virtualbox无法使用,这是hyper-v和vt-x冲突了.需要关掉hyper-v的自启动.
  - bcdedit /set hypervisorlaunchtype auto(用hyper-v比如sandbox的时候)
  - bcdedit /set hypervisorlaunchtype off(用vt-x比如virtualbox时)
- 突然发现按键盘方向键鼠标会跟着移动?某些按键组合可以触发鼠标双击/右键?这是玄妙的`鼠标键`功能.
  - 首先需要去control panel关掉它(`control panel>ease of access`)
  - 然后还要从硬件层次ban掉(这里不同的物理机是不一样的,比如dell和Lenovo是不同的).
- 突然无端弹出`windows资源管理器`(就按下ctrl+E可以启动的那个东西,他叫`explorer.exe`)
  - 问问baidu,bing,google.是软件设置的锅…
- 在virtualbox中使用某OS的iso镜像安装成功,reboot之后又回到了安装界面而没有地由bootloader加载OS?
  - 关掉虚拟机,回到virtualbox的启动界面,进入`settings>storage(设置-存储)`把直接加入的ISO光盘从存储介质中移除.重新启动,这样就可以从分配的虚拟硬盘上面的bootloader启动而不是ISO镜像里面的东西启动安装了.
- 在virtualbox中虚拟机的分辨率不能自适应,调整也不起效.这是因为使用`VMSVGA`显卡选项,换成`VBoxSVGA/VBoxVGA`就行了.


## tips(on Linux)
> distro:manjaro  
> de:kde

- 多看arch wiki/manjaro wiki,多去forum找找解决方案.

- 虽然linux distro和windows不一样,不用经常reboot,但是reboot还是一个能解决不少问题的方法...当然有时候logout一下再回来,重启一下DE/WM就好了..

- manjaro是滚动发行版,可能出现新问题,旧问题可能被消除,解决方案可能会失效,尽量自己找第一手信息.

- manjaro特色之一: mhwd,有`mhwd-tui,mhwd`分别对应TUI和CLI,可以轻松配置driver,kernel.

- 换中国境内的软件源`sudo pacman-mirrors -i -c China -m rank`,也可以和arch一样直接编辑`/etc/pacman.conf /etc/pacman.d/mirrorlist`全球镜像列表自行去manjaro/arch官网找.

- [ban掉beep,参考arch wiki修改配置文件即可](https://wiki.archlinux.org/index.php/PC_speaker):在`/etc/modprobe.d/nobeep.conf`写入`blacklist pcspkr`之后reboot即可.

- ==(输入法看这里)==经过各种尝试,使用fctix5是目前最好的方案.参考[archwiki:fcitx5](https://wiki.archlinux.org/index.php/Fcitx5)进行安装,配置即可,不再需要`找启动脚本,手动编辑,插入输入法环境变量`的繁琐过程.(经过实际检测,qt/gtk应用可以正常使用输入法,基于wine的移植应用也都没问题).

- 安装的基于wine移植的应用启动不了?也许是改变了安装目录,没有按照默认配置安装,找到这个应用的启动脚本(一般是在`/opt/deepinwine/apps/Deepin-{appname}/run.sh`),其中的`CallApp()`函数中`env WINEPREFIX=$WINEPREFIX$.....`一行中把应用的实际安装路径(最好用绝对路径)写入即可.

- ==(DE/WM字体配置看这里)==font,locale,参考[arch wiki:localization](),[arch wiki:font configuration]()
  修改`/etc/locale.gen`然后`sudo locale-gen`  
  你的DE可能会覆盖手动编写的`locale.gen`有DE时可以直接在DE中配置本地化(关键词 language,locale,format).  
  按照arch wiki上面字体配置部分修改`/etc/fonts/local.conf`加入抗锯齿,禁止缩放等设定,参考中文字体设置中android显示效果的配置,之后reboot即可.  
  不要配置`~/.config/fontconfig/local.conf`,有`/etc/fonts/local.conf`的全局设定就够了.  
  如果有DE的话,还需要在DE中设置gui应用的字体,尽量和fontconfig的配置保持一致.   
  
- 使用arch的官方源安装texlive之后使用不了tlmgr管理CTAN包,这是个官方软件源bug,按照arch wiki上面[Texlive-tlmgr](https://wiki.archlinux.org/index.php/TeX_Live#tlmgr)修改配置即可,记得让tlmgr使用国内的CTAN镜像.**这里最好直接去tuna mirrors上面找texlive的最新版本iso来安装.**  
  **不要在bashrc,config.fish中配置MANPATH,只要配置了PATH就可以正常的被mandb索引到了,修改MANPATH会出现奇怪问题**  
  
- 字体配置推荐,无脑`Noto Sans CJK Sc`即可,个人体验来讲`Noto Sans`比`Source Sans`好一些,`Serif`字体不太习惯.对于等宽的编程字体,推荐`Source Code Pro`和`Liberation Mono`

- KDE中`display>scaling`缩放有bug,建议不要使用.屏幕上可能会无端出现一根白线,并且icon及font的渲染都会有问题.

- 选择困难症?不妨看看[arch wiki:general recommendation](),[arch wiki:List of applications/Utilities]()

- 关于fish shell的一些事情

  - fish shell有些配置是不兼容bash的,比如path,manpath之类的,他的配置文件是`~/.config/fish/config.fish`配置的语法也和bash不同...尽量不要用`set -U VAR, set -g VAR`这种会影响全局配置甚至其他shell的配置.

  - bash中的`pacman -S $(cat softwarelist)`在fish中是`pacman -S (cat softwarelist)`.更常见的例子:`rm $(fzf -m)`应替换为`rm (fzf -m)`.

  - 中fish中一些regex的语法和fish shell的语法有冲突,使用单引号来标识他们,比如查询以rc结尾的配置文件应该这么写`ls ~/.config/ | grep 'rc$'`.

  关于vim的一些事情

  - 插件管理器推荐`vim-plug`在github可以找到它.

  - `:set hlsearch`使得vim给搜索匹配的文本加上高亮.搜索结束,暂时取消高亮用`:noh`即可.

  - 推荐插件:`nerdtree`,`nerdcommenter`,`indentLine`,`vim-airline`,`vim-startify`

- 关于deepin wine qq/wechat/tim不能查看图片(2020.7.16)
  - ipv6有一点问题,导致连不上腾讯的图片cdn,需要做一个本机的http proxy.
  - 安装`privoxy`,之后`systemctl enable,start`启动服务(manjaro的init是systemd,不是用systemd的话略有区别).
  - qq/wechat/tim登陆的时候配置http代理.默认是`http://127.0.0.1:8118`
  - 有其他问题,自行查阅`man privoxy`查找对应的配置文件进行修改...
  - 请自行找`/etc/privoxy/config`里面的内容过滤,搜素`toggle`把它们都关掉.
  - 还不行的话只能暂时禁用ipv6...或者virtualbox装个windows虚拟机跑了.

- 关于pandoc+xelatex下的`markdown+latex -> tex -> pdf`工作流.
  - 需要修改pandoc的转换模板,使得`markdown->tex`时具有正常的文档结构和设定的常用包以及字体配置.
  - 推荐使用[link:Eisvogel](https://github.com/Wandmalfarbe/pandoc-latex-template)这个LaTeX模板.参考他们的readme就可以正常使用了(参考命令`pandoc note.md -o book.pdf  --template eisvogel --listings --pdf-engine=xelatex`).
  - 这里因为`tex->pdf`是LaTeX提供的,所以比mathjax的语法要求要强一些,版本升级会产生语法不向后兼容的问题,请自行查找资料或询问网友.
  - 字体配置比较麻烦,参考arch wiki中关于texlive的帮助页,自行将texlive安装时带有的字体加入系统的字体中.



## LaTeX FAQ
- 如何换行:在数学环境中,直接使用`\\`是无法换行的,需要一个aligned环境才可以用(在aligned环境中需要注意使用`&`来标识对齐位置以及对齐起点),当然,你也可以用equation环境(默认居中对齐,不允许自定义对齐),如果不想要equation环境的自动编号,则用`\begin{equation*} \end{equation*}`代替.
- 如何使用多行下标:使用`\begin{subarray}{l/r/c} \end{subarray}`创建多行下标的环境,参数标识左/右对齐或者居中(在这个环境中,不可以使用`&`来自定义对齐规则).
- 为啥我用`p \and q`不行啊? 现在用的是`\land`不少参考资料已经过时了,建议查较近时间段的文档.
- 关于不等号`\gt \lt`,它们已经被废弃了,现在可以直接用`> <`输入了,其他不等式关系符号基本上没有调整.
- 为啥我空了一行就行了/不行了? 建议学习latex语法...不要乱用空格和反斜线,以及换行.
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
