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



------------------------

## disabling PC speaker; prevent beep

> date:2020.12.31

### 问题描述

进行一些操作,比如搜索/补全时,如果没有候选项,蜂鸣器会发出beep.  
日常工作中,我们用不到beeper.

### 参考信息

- [arch wiki: pc spearker](https://wiki.archlinux.org/index.php/PC_speaker)

### 解决方案

`echo "blacklist pcspkr" | sudo tee /etc/modprobe.d/nobeep.conf`


--------------------------

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


------------------------------------


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




-------------------------------------

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


-------------------------------------

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

-------------------------------------

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


## i3wm下touchpad配置

> date: 2021.1.05

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

## 修改rime InputMethod的config pannel的trigger keybinding

### 问题描述

> date: 2021.1.12

我在使用fcitx5+rime, 它默认有`<F4>`弹出设置面板的快捷键,非常容易冲突.

### 参考信息

- [github/rime/home: rime user guide: 定制呼出选项单的快捷键](https://github.com/rime/home/wiki/CustomizationGuide#%E4%B8%80%E4%BE%8B%E5%AE%9A%E8%A3%BD%E5%96%9A%E5%87%BA%E6%96%B9%E6%A1%88%E9%81%B8%E5%96%AE%E7%9A%84%E5%BF%AB%E6%8D%B7%E9%8D%B5)

fcitx+rime的情况,rime会认一些在用户家目录中的配置文件.

### 解决方案

编辑`~/.local/share/fcitx5/rime/build/default.yaml`,之后synchronize+deploy一下rime.  

具体而言.找到这样一段内容,删掉F4.  
至于我们如何在不好好读doc的情况下找到这个文件...  
那当然是`rg -l ~ --files --hidden | rg rime | rg default | rg yaml`,  
也可以简单一点`rg -l ~ --files --hidden | fzf`之后搜`default.yaml`

```yaml
switcher:
  abbreviate_options: true
  caption: "〔方案選單〕"
  fold_options: true
  hotkeys:
    - F4
    - "Control+grave"
    - "Control+Shift+grave"
  option_list_separator: "／"
  save_options:
    - full_shape
    - ascii_punct
    - simplification
    - extended_charset
    - zh_hant
    - zh_hans
    - zh_hant_tw
```


## HiDPI display scaling and font scaling

> date: 2021.1.12

### 问题描述

我在使用i3wm,有两个monitor,一个`2560x1600 13.3inch`,另一个`3840x2160 27inch`,  
由于屏幕DPI太高而Xorg输出的DPI没有跟着改变, 默认情况下UI,font都太小了.  


### 参考信息

- ArchWiki/HiDPI
- ArchWiki/Xorg

需要做以下修改

- 让Xorg输出时DPI正确
- 设置一些gtk/qt相关environment variables,使得基于gtk/qt的gui app能够进行ui,font scaling.
- 对于一些特殊应用,进行更多设置...

### 解决方案

需要用到一些`xorg-apps` group中的一些packages, 主要是xdpyinfo,xrandr.  

使用`xdpyinfo | grep -B 2 resolution`查看X当前输出的DPI.  
使用xrandr调整X输出的DPI,比如我这里用`xrandr --output eDP --mode 2560x1600 --rate 60 --scale 1 --dpi 192`,
把它写入i3-config中使得i3 session启动时调整DPI.  


参考按照wiki,配置Xresoureces  
```
!PATH=~/.Xresoureces
Xft.dpi: 192

! These might also be useful depending on your monitor and personal preference:
Xft.autohint: 0
Xft.lcdfilter:  lcddefault
Xft.hintstyle:  hintfull
Xft.hinting: 1
Xft.antialias: 1
Xft.rgba: rgba
```


写入一些qt/gtk相关的环境变量我没有做,  
首先我还在使用KDE,它能够较好的管理缩放,
其次是我发现进行了上面的配置之后,我常用的GUI apps已经正常缩放了.


## fish shell, proxy settings

> date: 2021.1.13

### 问题描述

set/unset proxy environment variables in fish shell, and share them between sessions.

### 参考信息

- `fish -c help`
- fish shell official tutorial
- fish shell official documentation

1. `set --show VARIABLE_NAME`; `-x` for export; '-e' to erase; `-l,-g,-U;--local,--global,--universal` to specify scope;
2. universal: sort of permanent for the current user; shared between all the fish-shell sessions and preserved even after reboot.
3. global: can shadow universal ones; not visible between sessions or after reboot;
4. local: can shadow global ones;
5. `set -e VAR` will delete the variable in the nearest scope where `VAR` is set.
0. fish will automatically load functions in `~/.config/fish/functions/`  

**fish shell have special ways to deal with PATH**, try `set --help` for more information.


### 解决方案


```fish
#PATH=~/.config/fish/functions/proxy_on.fish
function proxy_on
	set -Ux all_proxy socks5://127.0.0.1:1089
	set -Ux http_proxy http://127.0.0.1:8889
	set -Ux https_proxy $http_proxy
	set -Ux ftp_proxy $http_proxy
	set -Ux rsync_proxy $http_proxy
	set -Ux no_proxy "localhost,127.0.0.1,localaddress,.localdomain.com"
end

#PATH=~/.config/fish/functions/proxy_off.fish
function proxy_off
	set -e all_proxy
	set -e http_proxy
	set -e https_proxy
	set -e ftp_proxy
	set -e rsync_proxy
	set -e no_proxy
end

#PATH=~/.config/fish/functions/proxy_dump.fish
function proxy_dump
	echo "all_proxy   = $all_proxy"
	echo "http_proxy  = $http_proxy"
	echo "https_proxy = $https_proxy"
	echo "ftp_proxy   = $ftp_proxy"
	echo "rsync_proxy = $rsync_proxy"
	echo "no_proxy    = $no_proxy"
end
```

As mentioned in the 5th tip, `set -e` can erase the variable in local/global/universal.  
So we might have to run `proxy_off` for a few times to thoroughly remove proxy environment.


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

## git: displaying unicode path

> 2021.03.24

git status, git commit中,中文路径显示不正确.
出现类似  
`modified:   "\321\203\321\201\321\202\320\260\320\275\320\276\320\262"`  
的显示效果.

### 参考资料

- [StackOverflow: how to make git properly display utf-8 encoded path](https://stackoverflow.com/questions/22827239/how-to-make-git-properly-display-utf-8-encoded-pathnames-in-the-console-window)

### 解决方案

```bash
git config --global core.quotepath off
```

## changing PowerButton event handler

> 2021.04.01
使用i3wm session,按下笔记本(型号:Lenovo_IdeaPad_S540_13ARE)的powerbutton会触发关机.  
由于经常误触,我希望修改按下电源键的效果.  


### 参考资料


- [arch wiki: power management / ACPI event](https://wiki.archlinux.org/index.php/Power_management#ACPI_events)


### 解决方案


修改`/etc/systemd/logind.conf`或者在`/etc/systemd/logind.conf.d/{CONFIGNAME}.conf`中写入配置.  


默认配置如下,

```
[Login]
#NAutoVTs=6
#ReserveVT=6
#KillUserProcesses=no
#KillOnlyUsers=
#KillExcludeUsers=root
#InhibitDelayMaxSec=5
#UserStopDelaySec=10
#HandlePowerKey=suspend
#HandleSuspendKey=suspend
#HandleHibernateKey=hibernate
#HandleLidSwitch=suspend
#HandleLidSwitchExternalPower=suspend
#HandleLidSwitchDocked=ignore
#HandleRebootKey=reboot
#PowerKeyIgnoreInhibited=no
#SuspendKeyIgnoreInhibited=no
#HibernateKeyIgnoreInhibited=no
#LidSwitchIgnoreInhibited=yes
#RebootKeyIgnoreInhibited=no
#HoldoffTimeoutSec=30s
#IdleAction=ignore
#IdleActionSec=30min
#RuntimeDirectorySize=10%
#RuntimeDirectoryInodes=400k
#RemoveIPC=yes
#InhibitorsMax=8192
#SessionsMax=8192
```


我们需要修改的是`HandlePowerKey`的event handler,比如改成`systemd suspend`

```
[Login]
HandlePowerKey=suspend
```
