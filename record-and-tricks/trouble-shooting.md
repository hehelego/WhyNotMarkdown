# record on trouble shooting

> 我的环境(更新时间 2020.12.31), 信息来源于lshw,neofetch,uname等等工具  
> - 小新pro13 2020,amdcpu版本(xiaoxin pro 13-are 2020);可选配件是ryzen4800u+16gRAM+512gSSD
> - OS: `ArchLinux on x86_64`
> - DE: KDE plasma / i3wm

> 一些redminder  
> - 学会使用搜索引擎. arch wiki,arch forum,StackOverflow,UnixStackExchange,github,网友blog...到处都是资料(别忘了还有gentoo wiki).
> - arch是rolling release, 记得每天`sudo pacman -Syu`,记得即使更换掉过时软件包.
> - 任何更新都可能影响之前的解决方案,尽量查阅第一手资料,确保时效性.
> - re-boot/re-login/restart xorg都有可能有用.


[TOC]

## 联想小新系列笔记本USB-C接口失效的问题

> 2020.11.15修锅

### 问题描述

> lshw输出如下
> ```
> description: Notebook
> product: 82DM (LENOVO_MT_82DM_BU_idea_FM_XiaoXinPro-13ARE 2020)`
> vendor: LENOVO
> version: Lenovo XiaoXinPro-13ARE 2020
> serial: PF2DR2KS
> width: 64 bits
> ```
> 相关信息  
> BIOS version: 27ww  
> kernel: x86_64 Linux 5.9.8-arch1-1

USB type C 接口失效. PD,DP,USB协议全部无法使用,对外供电也失效.  
journalctl中包含`USBC`相关的错误信息.  

### 参考信息

~~联想小新系列笔记本是中国国内专有产品线而非全球产品系列.~~ update: 这个笔记本在中国叫`Xiaoxin Pro 13 2020`,国际市场称`Ideapad S540-13ARE`.
使用`journalctl -r --this-boot`找黄色/红色的warning,error,在google/bing上检索错误信息;在arch,ubuntu的用户论坛上查找相关thread,但是并不能解决这个问题.  
最后在联想中国论坛上找到了解决方案.  

- [link:联想中国论坛,关于小新系列笔记本的常见问题](https://club.lenovo.com.cn/thread-5850476-1-1.html)
- [arch wiki: Lenovo IdeaPad S540-13ARE](https://wiki.archlinux.org/index.php/Lenovo_IdeaPad_S540_13ARE) 发现arch wiki上面有这个笔记本的entry,我果断edit,把这个问题的解决方案加了上去. 此外.在这里发现了使用acpi call切换电池模式,开启快充的方案.

### 解决方案

1. 关机,断开供电.
2. 断开所有外部接口. 包括USB,3.5mm耳机孔,HDMI接口等.
3. 按住`Fn+S+V`进入电池运输模式,使得机器彻底掉电. 并按下电源键,确定无法开机,已经进入电池运输模式.
4. 连接到电源适配器进行供电的条件下,开机.  


如果USB type C接口仍然不能恢复正常,则可能是BIOS或者主板问题,建议返修.  



------------------------

## disabling PC speaker; prevent beep

2021.1.05

### 问题描述

进行一些操作,比如搜索/补全时,如果没有候选项,蜂鸣器会发出beep.  
日常工作中,我们用不到beeper.

### 参考信息

- [arch wiki: pc spearker](https://wiki.archlinux.org/index.php/PC_speaker)

### 解决方案

`echo "blacklist pcspkr" | sudo tee /etc/modprobe.d/nobeep.conf`


--------------------------

## CJK font selection error

2021.1.05

> 字体配置是个有些麻烦的事情`hiting,aliasing,bitmap,dpi`会有不少问题.也许交给DE是个更好的选择.   
> 有些应用不认fontconfig,需要专门配置,比如firefox/alacritty.

### 问题描述

使用Noto Sans/Serif CJK时,一些字型不正常.  
比如`门 关 复`

### 参考信息

CJK字符一般会区分SC,TC,JP,KR(简中,繁中,日文,韩文),而选择使用那种由fontconfig控制  
fontconfig中对于CJK字型选取的默认设置不符合预期,需要手写一个fontconfig配置文件.  

- [zhihu: 如何正确为NotoSansCJK配置fontconfig使中文不会被显示为日文字型](https://www.zhihu.com/question/47141667)
- [arch wiki: font configuartion](https://wiki.archlinux.org/index.php/Font_configuration)
- [arch wiki: fonts](https://wiki.archlinux.org/index.php/Fonts)
- [arch wiki: example for FCfile](https://wiki.archlinux.org/index.php/Font_configuration/Examples)
- [arch wiki: localization/simplified chinese](https://wiki.archlinux.org/index.php/Localization/Simplified_Chinese)


### 解决方案

可以在`~/.config/fontconfig/fonts.conf`或者`/etc/fonts/local.conf`中写入配置.  

```xml
<?xml version="1.0"?>
<!DOCTYPE fontconfig SYSTEM "fonts.dtd">
<fontconfig>
        <alias>
                <family>sans-serif</family>
                <prefer>
                        <family>Noto Sans CJK SC</family>
                        <family>Noto Sans CJK TC</family>
                        <family>Noto Sans CJK JP</family>
                        <family>Noto Sans CJK KR</family>
                </prefer>
        </alias>
        <alias>
                <family>serif</family>
                <prefer>
                        <family>Noto Serif CJK SC</family>
                        <family>Noto Serif CJK TC</family>
                        <family>Noto Serif CJK JP</family>
                        <family>Noto Serif CJK KR</family>
                </prefer>
        </alias>
        <alias>
                <family>monospace</family>
                <prefer>
                        <family>Noto Sans Mono CJK SC</family>
                        <family>Noto Sans Mono CJK TC</family>
                        <family>Noto Sans Mono CJK JP</family>
                        <family>Noto Sans Mono CJK KR</family>
                </prefer>
        </alias>
</fontconfig>
```


------------------------------------


## cpu turbo boost was disabled

### 问题描述

在一些未知条件下,节能模式被莫名其妙地开启  
CPU turbo boost被禁用,频率被锁定.  

### 参考信息

- [arch wiki: cpu frequency scaling](https://wiki.archlinux.org/index.php/CPU_frequency_scaling)

### 解决方案

向`/sys/devices/system/cpu/cpufreq/boost`中写入1开启boost.

```bash
# disable cpu turbo boost
echo 0 | sudo tee /sys/devices/system/cpu/cpufreq/boost
# enable cpu turbo boost
echo 1 | sudo tee /sys/devices/system/cpu/cpufreq/boost
```




-------------------------------------

## can't change backlight in i3wm session


2021.1.05

### 问题描述

在i3wm环境下,使用fn media keys中的backlight control无法正常调节屏幕亮度.

### 参考信息

根据arch wiki的信息,我这里是amdgpu的问题,需要特殊方式来调节backlight.

### 解决方案

直接向`/sys/class/backlight/amdgpu_bl0/brightness`写入亮度...    
这里的`amdgpu_bl0`可能需要换成其他GPU名称.  





-------------------------------------

## video hardware decoding in firefox

2021.1.05

### 问题描述

在网页中看视频,CPU usage爆炸,核心温度起飞,风扇狂转.  
显然是在软解视频...

### 参考信息

- [arch wiki:amdgpu](https://wiki.archlinux.org/index.php/AMDGPU)
- [arch wiki: hardware video acceleration](https://wiki.archlinux.org/index.php/Hardware_video_acceleration)
- [arch wiki: firefox-hardware video acceleration](https://wiki.archlinux.org/index.php/Firefox#Hardware_video_acceleration)
- [zhihu "白羊李志远"的文章:在Linux的Firefox上启用VA-API硬件解码](https://zhuanlan.zhihu.com/p/268401890)

### 解决方案

最后,reboot一下.  
我这里是AMD ryzen 4800U内置的vege 8 GPU,可以使用radeontop来观测它是否有负载.

-------------------------------------

## okular failed to render CJK font

2021.1.05


### 问题描述

okular打开包含中文的pdf,发现未嵌入的字体渲染异常.  


### 参考信息

- [linux-wiki.cn: PDF中文显示](http://linux-wiki.cn/wiki/PDF%E4%B8%AD%E6%96%87%E6%98%BE%E7%A4%BA)
- [ubuntu zh-wiki: PDF文档乱码问题 - okular乱码](https://wiki.ubuntu.org.cn/PDF%E6%96%87%E6%A1%A3%E7%9A%84%E4%B9%B1%E7%A0%81%E9%97%AE%E9%A2%98)
- [michellel.top 's cnblog: okular打开pdf,中文无法显示](https://www.cnblogs.com/guochaoxxl/p/6823148.html)

这些PDF没有将使用的字体内嵌,此时okular的后端`poppler`会寻找合适的已安装字体,  
而poppler的中文字体相关数据在`poppler-data`中,这个东西没有正确被安装,所以中文字体渲染出现了问题.


### 解决方案

安装`poppler,poppler-data`等poppler相关的软件包.  
或者换个PDF viewer


## i3wm下touchpad配置

2021.1.05

### 问题描述

在i3wm下,笔记本触控板无法使用单指触摸左键,双指触摸右键的功能.  

### 参考信息

目前touchpad的驱动配置由libinput提供.  
i3wm后端是Xorg,需要对应的`xf86-input-libinput`包.  


- [arch wiki: libinput](https://wiki.archlinux.org/index.php/Libinput)
- [gentoo wiki: libinput](https://wiki.gentoo.org/wiki/Libinput)
- [Cody Craven's blog post: Enable tap to clik in i3WM](https://cravencode.com/post/essentials/enable-tap-to-click-in-i3wm/)

### 解决方案

我们需要修改`xf86-input-libinput`的配置文件,重启Xorg.(显然这个只对Xorg有效...后端是wayland的话,比如sway环境需要另外的方案)  

根据gentoo wiki的指示,在`/etc/X11/xorg.conf.d/40-libinput.conf`中写入tap/scrolling的配置即可.

```plaintext
Section "InputClass"
     Identifier "libinput touchpad catchall"
     MatchIsTouchpad "on"
     MatchDevicePath "/dev/input/event*"
     Driver "libinput"
     Option "Tapping" "True"
     Option "TappingDrag" "True"
     Option "TappingButtonMap" "lrm"
     Option "NaturalScrolling" "True"
     Option "ScrollMethod" "twofinger"
     Option "accelSpeed" "0.3"
EndSection
```
