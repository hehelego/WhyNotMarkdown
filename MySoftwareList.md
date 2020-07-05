## installed software

### 通用跨平台软件
* firefox
* SageMath
* LibreOffice
* VLC
* ffmpeg
* 7zip(gui frontend:ark,gnome archive manager)
* telegram
* shadowsocks
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
* motrix
* syncthing
* etcher


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




### 小工具
* BILIdrive+CDNdrive
  * [cdn drive-pypi](https://pypi.org/project/CDNDrive/) [cdn drive-git](https://github.com/apachecn/CDNDrive) * [bili drive-pypi](https://pypi.org/project/BiliDriveEx/) [bili drive-git](https://github.com/apachecn/BiliDriveEx) * [ORIGIN-pypi](https://pypi.org/project/BiliDrive/) [ORIGIN-git](https://github.com/Hsury/BiliDrive)
  * [youget.git](https://github.com/soimort/you-get)
* YouGet
* ipython
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
  如果有DE的话,还需要在DE中设置gui应用的字体,尽量和fontconfig的配置保持一致. 
  ~~另外推荐去DE中`display>scaling`修改缩放为125%或者150%~~不推荐配置缩放,这会使得一些位图显示出现问题,以及屏幕撕裂...    
- 使用arch的官方源安装texlive之后使用不了tlmgr管理CTAN包,这是个官方软件源bug,按照arch wiki上面[Texlive-tlmgr](https://wiki.archlinux.org/index.php/TeX_Live#tlmgr)修改配置即可,记得让tlmgr使用国内的CTAN镜像.**这里最好直接去tuna mirrors上面找texlive的最新版本iso来安装.**
- fish shell有些配置是不兼容bash的,比如path,manpath之类的,他的配置文件是`~/.config/fish/config.fish`配置的语法也和bash不同...尽量不要用`set -U VAR, set -g VAR`这种会影响全局配置甚至其他shell的配置.
  **不要在bashrc,config.fish中配置MANPATH,只要配置了PATH就可以正常的被mandb索引到了,修改MANPATH会出现奇怪问题**
- 字体配置推荐,无脑`Noto Sans CJK Sc`即可,个人体验来讲`Noto Sans`比`Source Sans`好一些,`Serif`字体不太习惯.对于等宽的编程字体,推荐`Source Code Pro`和`Liberation Mono`
- 选择困难症?不妨看看[arch wiki:general recommendation](),[arch wiki:List of applications/Utilities]()



## stared repositories

[github stars:hehelego](https://github.com/hehelego?tab=stars)
