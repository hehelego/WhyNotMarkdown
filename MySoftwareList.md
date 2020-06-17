## installed software

### 通用跨平台软件
* chrome `browser`
* Firefox`browser`
* SageMath
* LibreOffice
* VLC media player
* ffmpeg
* 7zip
* telegram
* shadowsocks
* git
* vim/neovim(with vim-plug)
* GNU toolchain(gcc,g++,gdb,make...)
* python(pip+virtualenv)
* rustup
* stack(for haskell toolchain)
* typora
* pandoc
* virtualbox
* lemon(project-lemon 一个OI比赛测试系统)
* aria2
* qBittorrent
* motrix
* syncthing


### windows
* Avast antivirus
* huorong antivirus
* ccleaner
* tim(QQ)+wechat
* cloudmusic(netease music)
* **msys2**(Gnu toolchain,git,ssh....轻量级的模拟linux环境)
* everything
* windows sandbox
* powershell
* github desktop
* OneDrive
* 
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
* fish
* fzf
* ranger
* krunner(or albert)



### 小工具
* BILIdrive+CDNdrive
  * [cdn drive-pypi](https://pypi.org/project/CDNDrive/) [cdn drive-git](https://github.com/apachecn/CDNDrive)
  * [bili drive-pypi](https://pypi.org/project/BiliDriveEx/) [bili drive-git](https://github.com/apachecn/BiliDriveEx)
  * [ORIGIN-pypi](https://pypi.org/project/BiliDrive/) [ORIGIN-git](https://github.com/Hsury/BiliDrive)
  * [youget.git](https://github.com/soimort/you-get)
* YouGet
* ipython
### 浏览器插件
* charset(automatically detect&change encoding of a page)
* Tampermonkey
* OneTab
* Cookie Quick Manager(on firefox)
* Firefox(Print Edit We+Save Page We) / chrome(CtrlP print to PDF)







## useful tricks&FAQ
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
  - 首先需要去control panel关掉它(control panel>ease of access)
  - 然后还要从硬件层次ban掉(这里不同的物理机是不一样的,比如dell和Lenovo是不同的).
- 突然无端弹出`windows资源管理器`(就按下ctrl+E可以启动的那个东西,他叫`explorer.exe`)
  - 问问baidu,bing,google.是软件设置的锅…
- 在virtualbox中使用某OS的iso镜像安装成功,reboot之后又回到了安装界面而没有地由bootloader加载OS?
  - 关掉虚拟机,回到virtualbox的启动界面,进入settings>storage(设置-存储)把直接加入的ISO光盘从存储介质中移除.重新启动,这样就可以从分配的虚拟硬盘上面的bootloader启动而不是ISO镜像里面的东西启动安装了.




## stared repositories

[github stars:hehelego](https://github.com/hehelego?tab=stars)