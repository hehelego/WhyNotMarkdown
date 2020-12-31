# record on trouble shooting

> 我的环境(更新时间 2020.12.31), 信息来源于lshw,neofetch,uname等等工具  
> - 小新pro13 2020,amdcpu版本(xiaoxin pro 13-are 2020);可选配件是ryzen4800u+16gRAM+512gSSD
> - OS: `ArchLinux on x86_64`
> - DE: KDE plasma / i3wm

> 一些redminder  
> - 学会使用搜索引擎. arch wiki,arch forum,StackOverflow,UnixStackExchange,github,网友blog...到处都是资料.
> - arch是rolling release, 记得每天`sudo pacman -Syu`,记得即使更换掉过时软件包.
> - 任何更新都可能影响之前的解决方案,尽量查阅第一手资料,确保时效性.
> - re-boot/re-login/restart xorg都有可能有用.


[TOC]

## 联想小新系列笔记本USB-C接口失效的问题

> 2020.11.15修锅

### 问题描述

> lshw输出如下
> description: Notebook
> product: 82DM (LENOVO_MT_82DM_BU_idea_FM_XiaoXinPro-13ARE 2020)
> vendor: LENOVO
> version: Lenovo XiaoXinPro-13ARE 2020
> serial: PF2DR2KS
> width: 64 bits

> 相关信息
> BIOS: 27ww
> kernel: x86_64 Linux 5.9.8-arch1-1

USB type C 接口失效. PD,DP,USB协议全部无法使用,对外供电也失效.  
journalctl中包含`USBC`相关的错误信息.  

### 参考信息

联想小新系列笔记本是中国国内专有产品线而非全球产品系列.  
使用`journalctl -r --this-boot`找黄色/红色的warning,error,在google/bing上检索错误信息;在arch,ubuntu的用户论坛上查找相关thread.  
最后在联想中国论坛上找到了解决方案.  

[link](https://club.lenovo.com.cn/thread-5850476-1-1.html)


### 解决方案

1. 关机,断开供电.
2. 断开所有外部接口. 包括USB,3.5mm耳机孔,HDMI接口等.
3. 按住`Fn+S+V`进入电池运输模式,使得机器彻底掉电. 并按下电源键,确定无法开机,已经进入电池运输模式.
4. 连接到电源适配器进行供电的条件下,开机.  


如果USB type C接口仍然不能恢复正常,则可能是BIOS或者主板问题,建议返修.  



------------------------

## disabling PC speaker; prevent beep

### 问题描述

进行一些操作,比如搜索/补全时,如果没有候选项,蜂鸣器会发出beep.  
日常工作中,我们用不到beeper.

### 参考信息

- [arch wiki: pc spearker](https://wiki.archlinux.org/index.php/PC_speaker)

### 解决方案

`echo "blacklist pcspkr" | sudo tee /etc/modprobe.d/nobeep.conf`


--------------------------

## CJK font selection error

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



-------------------------------------

## can't change backlight in i3wm session

### 问题描述

### 参考信息

根据arch wiki的信息,我这里是amdgpu的问题,需要特殊方式来调节backlight.

### 解决方案

直接向`/sys/class/backlight/amdgpu_bl0/brightness`写入亮度...    
这里的`amdgpu_bl0`可能需要换成其他GPU名称.  





-------------------------------------

## video hardware decoding in firefox

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



