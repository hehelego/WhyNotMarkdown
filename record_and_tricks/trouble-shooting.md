# record on trouble shooting

> 我的环境(更新时间 2020.12.31), 信息来源于lshw,neofetch,uname等等工具  
> - 小新pro13 2020,amdcpu版本(xiaoxin pro 13-are 2020);可选配件是ryzen4800u+16gRAM+512gSSD
> - fOS: `ArchLinux on x86_64`
> - DE: KDE plasma / i3wm

> 一些redminder  
> - 学会使用搜索引擎. arch wiki,arch forum,StackOverflow,UnixStackExchange,github,网友blog...到处都是资料(别忘了还有gentoo wiki).
> - arch是rolling release, 记得每天`sudo pacman -Syu`,记得即使更换掉过时软件包.
> - 任何更新都可能影响之前的解决方案,尽量查阅第一手资料,确保时效性.
> - re-boot/re-login/restart xorg都有可能有用.


[TOC]

## 联想小新系列笔记本USB-C接口失效的问题

> date:2020.11.15

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


### 追加信息

- 2021/02/22, 2020/02/23 这台机器出现严重故障, 根据症状推测为内存错误或EC错误.  
  还好在保修期内,送维修点检测后,更换了主板,目前已经不会在出现这个问题了.  
  但是这个操作仍然有记录价值,笔记本拆机不方便,需要一个便捷地清空CMOS电池的方式以解决其他问题.


## CJK font selection error

> date:2021.12-31

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




## cpu turbo boost was disabled

> date: 2021.1.6

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





## can't adjust backlight in i3wm session

> date: 2021.12.31

### 问题描述

在i3wm环境下,使用fn media keys中的backlight control无法正常调节屏幕亮度.  
经过一番尝试,在KDE session之外的任何地方都没法正常调节,比如i3 session/sway session/tty都不行.  
使用`xorg-xbacklight`也不行.

### 参考信息

- [arch wiki: backlight](https://wiki.archlinux.org/index.php/Backlight)
- [arch wiki: xbindkeys](https://wiki.archlinux.org/index.php/Xbindkeys)

### 解决方案

可以直接向`/sys/class/backlight/amdgpu_bl0/brightness`写入亮度...   
这里的`amdgpu_bl0`可能需要换成其他GPU名称.  

```bash
echo {brightness} | sudo tee /sys/class/backlight/amdgpu_bl0/brightness
```

参考arch wiki关于backlight的词条,在`/sys/class/backlight/`中找到了可以调节背光的显卡驱动模块,  
所以我这台机子属于 使用ACPI调节.  

删掉xorg-xbacklight,安装acpilight. 发现可以正常调节亮度了,但是仅限root.
将日常使用的用户加入video group; 添加udev rule,允许video组用户修改backlight.  

```plaintext
#PATH /etc/udev/rules.d/backlight.rules
ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="amdgpu_bl0", GROUP="video", MODE="0664"
```

之后向i3-config中添加backlight control的media key的bindsym.

```plaintext
#PATH ~/.config/i3/config

# mediakey:: adjust volume in PulseAudio.
set $refresh_i3status killall -SIGUSR1 i3status
bindsym XF86AudioRaiseVolume exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ +5% && $refresh_i3status
bindsym XF86AudioLowerVolume exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ -5% && $refresh_i3status
bindsym XF86AudioMute exec --no-startup-id pactl set-sink-mute @DEFAULT_SINK@ toggle && $refresh_i3status
bindsym XF86AudioMicMute exec --no-startup-id pactl set-source-mute @DEFAULT_SOURCE@ toggle && $refresh_i3status

# mediakey:: media player   (need playerctl)
bindsym XF86AudioPlay exec playerctl play-pause
bindsym XF86AudioPause exec playerctl play-pause
bindsym XF86AudioStop exec playerctl stop
bindsym XF86AudioNext exec playerctl next
bindsym XF86AudioPrev exec playerctl previous

# mediakey:: backlight control   (need xorgs-xbacklight or acpilight)
bindsym XF86MonBrightnessUp exec xbacklight -inc 10
bindsym XF86MonBrightnessDown exec xbacklight -dec 10
```

如果失败,可以尝试添加`acpi_backlight=native`的kernel parameter.



## video hardware decoding in firefox

> date: 2020.12.31

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


## okular failed to render CJK font

> date: 2021.1.1


### 问题描述

okular打开包含中文的pdf,发现未嵌入的字体渲染异常.  


### 参考信息

- [linux-wiki.cn: PDF中文显示](http://linux-wiki.cn/wiki/PDF%E4%B8%AD%E6%96%87%E6%98%BE%E7%A4%BA)
- [ubuntu zh-wiki: PDF文档乱码问题 - okular乱码](https://wiki.ubuntu.org.cn/PDF%E6%96%87%E6%A1%A3%E7%9A%84%E4%B9%B1%E7%A0%81%E9%97%AE%E9%A2%98)
- [michellel.top 's cnblog: okular打开pdf,中文无法显示](https://www.cnblogs.com/guochaoxxl/p/6823148.html)

这些PDF没有将使用的字体内嵌,此时okular的后端`poppler`会寻找合适的已安装字体,  
而poppler的中文字体相关数据在`poppler-data`中,这个东西没有正确被安装,所以中文字体渲染出现了问题.


### 解决方案

- 安装`poppler,poppler-data`等poppler相关的软件包.  
- 安装更多字体.  
  例如:MS windows中常见的`Courier,Times fonts` fallback到noto fonts的效果并不好,用liberation fonts替代效果更好.


## pulseaudio can't resume sink/source after recovery from hibernation/suspend.

> date: 2020.1.15

### 问题描述

audio output failed. the sinks/sources are suspended and can't be resumed by pactl.

### 参考信息

- pactl: tldr pages,man pages.
- `pactl list sinks short`,`pactl list sources short`
- [arch wiki: pulseaudio](https://wiki.archlinux.org/index.php/PulseAudio#Running)
- `journalctl`


### 解决方案

restart pulseaudio.

```
systemctl --user restart pulseaudio.service
systemctl --user restart pulseaudio.socket
```


## v2ray 系统时间未同步导致连接失败

> date 2021.02.26

### 问题描述

v2ray vmess/tcp 连接失败, 出现类似下方的log

```
2021/02/26 23:01:37 [Warning] [1842356649] v2ray.com/core/app/proxyman/inbound: connection ends > v2ray.com/core/proxy/http: connection ends > v2ray.com/core/proxy/http: failed to write response > write tcp 127.0.0.1:8889->127.0.0.1:48022: write: broken pipe
2021/02/26 23:01:38 [Warning] [977784748] v2ray.com/core/proxy/http: failed to read response from 149.154.167.91:80 > unexpected EOF
```

常在长时间hibernate后resume时出现.


### 参考信息

- v2ray vmess/tcp需要时间同步
- [arch wiki: system time](https://wiki.archlinux.org/index.php/System_time)
- [arch wiki: systemd-timesyncd](https://wiki.archlinux.org/index.php/Systemd-timesyncd)

此外,还有以下问题可能导致这种断连接.

- 出口为校园网, 登录到期需要重新认证.  
  此时需要临时关闭代理,用默认浏览器打开任意站点,弹出校园网认证重新登录即可.
- 代理路线挂了, 请利用所有渠道获取更多信息并尝试解决.
- 确实断网了...

### 解决方案

启用NTP时间同步,重启时间同步服务以强制进行同步.

```bash
timedatectl set-ntp true
systemctl enable systemd-timesyncd.service
systemctl restart systemd-timesyncd.service
```

如无法正确同步,可以尝试更换`timesyncd`使用的NTP server.




## hibernate(suspend, save to disk) with swapfile

> date 2021.02.27

前段时间主力机(一台ideapad S540 ARE,或者叫 联想小新Pro13 2020 are)的主板挂了(板载内存或者EC的问题), 还好在保修期内. 维修失去了磁盘数据, 重新配置系统,记录一下比较麻烦的休眠配置.

### 问题描述

使用swap partition无法调整大小, 尝试使用swapfile.

### 参考信息

- [archwiki: suspend & hibernate](https://wiki.archlinux.org/index.php/Power_management/Suspend_and_hibernate)
- [archwiki: swapfile](https://wiki.archlinux.org/index.php/Swap#Swap_file)


### 解决方案

1. 创建 swapfile
```
sudo su
dd if=/dev/zero of=/swapfile bs=1G count=20 status=progress
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
echo "/swapfile none swap defaults 0 0" >> /etc/fstab
exit
```

2. 配置 init ram fs

编辑`/etc/mkinitcpio.conf`,在`HOOKS`中添加`resume`. 或者这添加`systemd`.  
使用`sudo mkinitcpio -P`重新重新生成initramfs.

3. 添加 kernel parameter

这里我使用grub bootloader,它提供kernel parameters.  
在`/etc/default/grub`中写入配置(`GRUB_CMDLINE_LINUX_DEFAULT`一项), 添加resume和resume offset参数.

```bash
resume=UUID={{findmnt -no UUID -T /swapfile}}
swap_file_offset={{sudo filefrag -v /swapfile | awk '{ if($1=="0:"){print substr($4, 1, length($4)-2)} }'}}..
```

4. reboot,检验功能

`cat /proc/cmdline`查看kernel parameter确定配置成功,并`systemctl hibernate`测试.


## eliminating the vertical padding at the bottom in a terminal emulator 

> 2021.04.16

### 问题描述

在i3wm环境下,打开一个`konsole`/`alacritty`,经常发现末尾有留空的一行/半行,  
使用vim时,终端模拟器中vim的last line和桌面的menu bar之间有很大的间隙,非常难受.  

修改窗口大小,比如开启另一个窗口与之并存尝试resize,或者进入floating mode进行resize.

### 参考信息

- `alacritty` 官方参考示例配置,在`/usr/share/doc/alacritty/example/alacritty.yml`
- telegram arch-linux-user-group 群友解答

### 解决方案

这并非 `alacritty` 配置中的 `window/padding/y` 选项控制,
而是因为字体大小不整除终端模拟器占有的纵向长度,导致末尾不足一行,只能留空.  


需要手动调节字体大小(比如在我这里 `resolution=2560x1600, dpi=192`,有上下的titile bar, menu bar; 使用font size 11是恰好不会留白).  
当然换显示器,调整DPI,甚至调整窗口大小都会改变可用的字体大小, 需要便捷调节的方式.  
在常见的终端模拟器中,都支持`Ctrl +`,`Ctrl -`的快捷键调整字体大小.

## can not perform repeat when a key is pressed down and holden.

> 2021.5.15
> 这是很久之前遇到的问题,在telegram cn arch user group里面问到了解决方案. 
> 当时忘了记录,现在想起来,写下来.

### 问题描述

使用fcitx5时,长按一个键,无法重复输出这个字符.

### 参考信息

- arch wiki: fcitx5

### 解决方案

一些qt/gtk应用没有加入`fcitx5`的识别,只有`fcitx`的支持,所以如下的环境变量产生了问题.

```plaintext
GTK_IM_MODULE=fcitx5
QT_IM_MODULE=fcitx5
SDL_IM_MODULE=fcitx5
```

但是`fcitx5`是基本兼容`fcitx`的,所以这里`fcitx5 -> fcitx`即可.

```plaintext
GTK_IM_MODULE=fcitx
QT_IM_MODULE=fcitx
SDL_IM_MODULE=fcitx
XMODIFIERS=@im=fcitx
```

## vim highlight cleared after changing colorscheme

> 2021.5.15

### 问题描述

启动时使用`colorscheme gruvbox`,
使用中切换到其他配色,
发现很多`highlight group`被清除了,
比如`signcolumn`中的来自LSP的`warning,error`.


### 参考信息

- [github/vim issue: How to mitigate highlighting issues when switching colorschemes](https://github.com/vim/vim/issues/4405)
- gruvbox,one的vim colorscheme源文件

### 解决方案

colorscheme的源文件中含有`hi clear; syntax clear`等初始化清空操作.  
导致了颜色清空, 但是并没有正确地设置新的`highlight group`

**TODO**
暂时未解决 temporarily unable to fix it.


