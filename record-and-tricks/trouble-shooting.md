# record on trouble shooting

> 我的环境(更新时间 2020.12.31), 信息来源于lshw,neofetch,uname等等工具  
> - 小新pro13 2020,amdcpu版本(xiaoxin pro 13-are 2020);可选配件是ryzen4800u+16gRAM+512gSSD
> - OS: `ArchLinux on x86_64`
> - DE: KDE plasma / i3wm

> 一些redminder  
> - 学会使用搜索引擎. arch wiki,arch forum,StackOverflow,UnixStackExchange,github,网友blog...到处都是资料  
> - arch是rolling release, 记得每天`sudo pacman -Syu`,记得即使更换掉过时软件包.
> - re-boot/re-login/restart xorg都有可能游泳


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


### 问题描述

使用Noto Sans/Serif CJK时,一些字型不正常.   
比如`门`上出现了奇怪的一竖  

### 参考信息

- [zhihu: 如何正确为NotoSansCJK配置fontconfig使中文不会被显示为日文字型](https://www.zhihu.com/question/47141667)
- [arch wiki: font configuartion (中文翻译)](https://wiki.archlinux.org/index.php/Font_configuration_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87))
- [arhch wiki: fonts (中文翻译)](https://wiki.archlinux.org/index.php/Fonts_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87))
- [arch wiki: font configuartion](https://wiki.archlinux.org/index.php/Font_configuration)
- [arch wiki: fonts](https://wiki.archlinux.org/index.php/Fonts)


### 解决方案

***试探中todo***



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



