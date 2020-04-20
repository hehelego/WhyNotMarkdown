#### installed softwares

* chorme `browser`
* firefox `browser`
* avast antivirus
* huorong antivirus
* ccleaner
* cloudmusic(netease music)
* codeblocks(for mingw)
* everything
* GithubDesktop
* gvim
* lemon+LemonLime
* LibreOffice
* splayer `video player`
* VLC media player
* VirtualBox+putty+(linuxmint)
* windows sandbox
* python3
* Shadowsocket
* telegram
* tim `tencentQQ`
* typora `markdown pad`  
* SageMath[link](<https://www.sagemath.org/>)
* stack(for haskell [link](<https://docs.haskellstack.org/en/stable/README/>))
* pandoc+ffmpeg(file format converters)
* BILIdrive+CDNdrive
  * [cdn drive-pypi](https://pypi.org/project/CDNDrive/) [cdn drive-git](https://github.com/apachecn/CDNDrive)
  * [bili drive-pypi](https://pypi.org/project/BiliDriveEx/) [bili drive-git](https://github.com/apachecn/BiliDriveEx)
  * [ORIGIN-pypi](https://pypi.org/project/BiliDrive/) [ORIGIN-git](https://github.com/Hsury/BiliDrive)







* qBittorrent
* PanDownload
* LocaleEmulator
* ONScripter
* VisualNovelReader
* Yuki[github yuki](<https://github.com/project-yuki/YUKI>)

#### browser plugins
* charset(to automaticly change the encoding of a web page,on chrome)
* Tampermonkey(userscript manager)
* OneTab(on chrome+firefox)
* Cookie Quick Manager(on firefox)
* Firefox(Print Edit We+Save Page We) + chrome(CtrlP print to PDF) -> perfect PDF

#### useful tricks&solution to frequently happening problems
* markdown:`[TOC]`建立可以生成token表,当目录用..
* win+shift+s (screen shot)
* windows10更新出锅,一堆应用启动不了,能查到进程,但是UI显实不了/进入不了REPL,敲入命令后卡住.建议清空windows临时文件,可以everything手动查找临时文件(C:/Users/{UserName}/AppData/Local/Temp)删除,或者使用Ccleaner自动清空….如果仍然不行,可以重启explorer.exe
* windows10更新出锅,启动后desktop不显示.建议(ctrl+alt+del,alt+T),召唤任务管理器,(alt+F+N)输入explorer,启动windows资源管理器(explorer.exe)…
* 上面的软件不少是open source的,并且有国内镜像,可以尝试到tuna(Thu建立),ustc mirror找找镜像,在GFW之内也能高速下载/更新.
* Windows的console中,使用`chcp 65001`钦定console使用utf-8编码.
* vim for windows中有些奇怪的map使得`Ctrl+V`无法进入`visual-block`模式(批量注释之类的功能),找到vim安装目录中的`mswin.vim`,注释掉这一行.

```vim
" CTRL-V and SHIFT-Insert are Paste
map <C-V> "+gP
```

- windows sandbox需要在`控制面板>程序与功能>启动关闭windows功能`中启动
  - hyper-V的全部功能
  - windows sandbox
  - windows 虚拟机监控程序平台
- 关于hyper-v启动之后无法实用virtualbox,这是hyper-v和vt-x冲突了,需要admin权限来修改配置.
  - bcdedit /set hypervisorlaunchtype Auto(用hyper-v比如sandbox的时候)
  - bcdedit /set hypervisorlaunchtype off(用vt-x比如virtualbox时)