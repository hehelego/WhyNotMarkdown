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
* etcher


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
  - 首先需要去control panel关掉它(control panel>ease of access)
  - 然后还要从硬件层次ban掉(这里不同的物理机是不一样的,比如dell和Lenovo是不同的).
- 突然无端弹出`windows资源管理器`(就按下ctrl+E可以启动的那个东西,他叫`explorer.exe`)
  - 问问baidu,bing,google.是软件设置的锅…
- 在virtualbox中使用某OS的iso镜像安装成功,reboot之后又回到了安装界面而没有地由bootloader加载OS?
  - 关掉虚拟机,回到virtualbox的启动界面,进入settings>storage(设置-存储)把直接加入的ISO光盘从存储介质中移除.重新启动,这样就可以从分配的虚拟硬盘上面的bootloader启动而不是ISO镜像里面的东西启动安装了.


## tips(on Linux)
> distro:manjaro
> de:xfce
- 多看arch wiki/manjaro wiki,多去forum找找解决方案.
- 换中国境内的软件源排`sudo pacman-mirrors -i -c China -m rank` 推荐thu,sjtu的镜像,不推荐ustc的镜像. 
- [improve font rendering](https://wiki.manjaro.org/index.php?title=Improve_Font_Rendering)
- [ban掉beep](https://wiki.archlinux.org/index.php/PC_speaker)
- 输入法
```bash
sudo pacman -S fcitx-sunpinyin
sudo pacman -S fcitx-im 
sudo pacman -S fcitx-configtool
```
在`～/.profile`中加入
```bash
export LC_CTYPE=zh_CN.UTF-8
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS="@im=fcitx"
```
- 字体,locale等本地化配置
参考[arch wiki:本地化](https://wiki.archlinux.org/index.php/Localization_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87)/Simplified_Chinese_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87)#locale%E8%AE%BE%E7%BD%AE),[字体配置](https://wiki.archlinux.org/index.php/Font_configuration_%28%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87%29),[中文字体设置](https://wiki.archlinux.org/index.php/Font_Configuration_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87)/Chinese_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87))

首先用pacman装一些中文字体,然后在`.config/fontconfig/fonts.conf`中加入
```xml
<?xml version="1.0"?>
<!DOCTYPE fontconfig SYSTEM "fonts.dtd">

<fontconfig>

    <its:rules xmlns:its="http://www.w3.org/2005/11/its" version="1.0">
        <its:translateRule translate="no" selector="/fontconfig/*[not(self::description)]"/>
    </its:rules>

    <description>Manjaro Font Config</description>

    <!-- Font directory list -->
    <dir>/usr/share/fonts</dir>
    <dir>/usr/local/share/fonts</dir>
    <dir prefix="xdg">fonts</dir>
    <dir>~/.fonts</dir> <!-- this line will be removed in the future -->

    <!-- 自动微调 微调 抗锯齿 内嵌点阵字体 -->
    <match target="font">
        <edit name="autohint"> <bool>false</bool> </edit>
        <edit name="hinting"> <bool>true</bool> </edit>
        <edit name="antialias"> <bool>true</bool> </edit>
        <edit name="embeddedbitmap" mode="assign"> <bool>false</bool> </edit>
    </match>

    <!-- 英文默认字体使用 Roboto 和 Noto Serif ,终端使用 DejaVu Sans Mono. -->
    <match>
        <test qual="any" name="family">
            <string>serif</string>
        </test>
        <edit name="family" mode="prepend" binding="strong">
            <string>Noto Serif</string>
        </edit>
    </match>
    <match target="pattern">
        <test qual="any" name="family">
            <string>sans-serif</string>
        </test>
        <edit name="family" mode="prepend" binding="strong">
            <string>Roboto</string>
        </edit>
    </match>
    <match target="pattern">
        <test qual="any" name="family">
            <string>monospace</string>
        </test>
        <edit name="family" mode="prepend" binding="strong">
            <string>DejaVu Sans Mono</string>
        </edit>
    </match>

    <!-- 中文默认字体使用思源宋体,不使用 Noto Sans CJK SC 是因为这个字体会在特定情况下显示片假字. -->
    <match>
        <test name="lang" compare="contains">
            <string>zh</string>
        </test>
        <test name="family">
            <string>serif</string>
        </test>
        <edit name="family" mode="prepend">
            <string>Source Han Serif CN</string>
        </edit>
    </match>
    <match>
        <test name="lang" compare="contains">
            <string>zh</string>
        </test>
        <test name="family">
            <string>sans-serif</string>
        </test>
        <edit name="family" mode="prepend">
            <string>Source Han Sans CN</string>
        </edit>
    </match>
    <match>
        <test name="lang" compare="contains">
            <string>zh</string>
        </test>
        <test name="family">
            <string>monospace</string>
        </test>
        <edit name="family" mode="prepend">
            <string>Noto Sans Mono CJK SC</string>
        </edit>
    </match>

    <!-- 把Linux没有的中文字体映射到已有字体，这样当这些字体未安装时会有替代字体 -->
    <match target="pattern">
        <test qual="any" name="family">
            <string>SimHei</string>
        </test>
        <edit name="family" mode="assign" binding="same">
            <string>Source Han Sans CN</string>
        </edit>
    </match>
    <match target="pattern">
        <test qual="any" name="family">
            <string>SimSun</string>
        </test>
        <edit name="family" mode="assign" binding="same">
            <string>Source Han Serif CN</string>
        </edit>
    </match>
    <match target="pattern">
        <test qual="any" name="family">
            <string>SimSun-18030</string>
        </test>
        <edit name="family" mode="assign" binding="same">
            <string>Source Han Serif CN</string>
        </edit>
    </match>
    
    <!-- Load local system customization file -->
    <include ignore_missing="yes">conf.d</include>
    <!-- Font cache directory list -->
    <cachedir>/var/cache/fontconfig</cachedir>
    <cachedir prefix="xdg">fontconfig</cachedir>
    <!-- will be removed in the future -->
    <cachedir>~/.fontconfig</cachedir>

    <config>
        <!-- Rescan in every 30s when FcFontSetList is called -->
        <rescan> <int>30</int> </rescan>
    </config>

</fontconfig>
```
在`/etc/fonts/local.font`中加入
```xml
<?xml version="1.0"?>
<!DOCTYPE fontconfig SYSTEM "fonts.dtd">
<fontconfig>
    <match target="font">
        <edit name="autohint" mode="assign">
            <bool>false</bool>
            </edit>
        <edit name="hinting" mode="assign">
            <bool>false</bool>
        </edit>
        <edit name="hintstyle" mode="assign">
            <const>none</const>
        </edit>
    </match>
</fontconfig>
```
- [网友的自体配置+中文输入法配置](https://yq.aliyun.com/articles/696518)
- 虽然manjaro是个linux distro,但是reboot还是一个能解决不少问题的方法...


## stared repositories

[github stars:hehelego](https://github.com/hehelego?tab=stars)
