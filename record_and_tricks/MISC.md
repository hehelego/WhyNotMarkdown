# MISC: note, records, links

> for "trouble shooting records" see `hehelego/WhyNotMarkdown/record-and-tricks/trouble-shooting.md`

[TOC]

## helpful arch-wiki/gentoo-wiki entries

- [arch wiki: installation guide](https://wiki.archlinux.org/index.php/Installation_Guide)
- [arch wiki: general recommendation](https://wiki.archlinux.org/index.php/General_recommendations)
- [arch wiki: list of applications](https://wiki.archlinux.org/index.php/List_of_applications)
- [arch wiki: FAQ](https://wiki.archlinux.org/index.php/Frequently_asked_questions)
- [arch wiki: pacman](https://wiki.archlinux.org/index.php/Pacman)
- [arch wiki: systemd](https://wiki.archlinux.org/index.php/Systemd)
- [arch wiki: arch boot process](https://wiki.archlinux.org/index.php/Arch_boot_process)
- [arch wiki: Xorg](https://wiki.archlinux.org/index.php/Xorg)

## disabling PC speaker; preventing beep

> date:2020.12.31

### 描述

进行一些操作,比如搜索/补全时,如果没有候选项,蜂鸣器会发出beep.  
日常工作中,我们用不到beeper.

### 参考信息

- [arch wiki: pc spearker](https://wiki.archlinux.org/index.php/PC_speaker)

### 解决方案

`echo "blacklist pcspkr" | sudo tee /etc/modprobe.d/no-pcspkr.conf`

## disabling integrated webcam

### description

For privacy and security reason, I 'd like to disable the integrated webcam on my laptop.  
The webcam is a UVC(USB video class) device.

### reference

- [arch wiki: webcam](https://wiki.archlinux.org/title/Webcam_setup)
- [arch wiki: kernel module](https://wiki.archlinux.org/title/Kernel_module)

### solution

disable the `uvcvideo` kernel module.

`echo "blacklist uvcvideo" | sudo tee /etc/modprobe.d/no-webcam.conf`

## 修改rime InputMethod的config pannel的trigger keybinding

### 描述

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

## fzf search for hidden files

### 问题描述

fzf不默认搜索dot files.  
`rg -l . --files --hidden | fzf -m` 太麻烦.  
并且使用`fzf.vim`集成插件时,也没法手动pipe.

### 参考信息

- [github fzf/issue : Including hidden files in search](https://github.com/junegunn/fzf/issues/337)
- [github fzf/readme.md](https://github.com/junegunn/fzf)

we can use the `FZF_DEFAULT_COMMAND` environment variable.

### 解决方案

```fish
set -Ux FZF_DEFAULT_COMMAND "fd -H --type file"
```

## fzf: enable keyboard-shortcuts and autocompletion

### 问题描述

在arch linux使用pacman安装fzf后, 没有获得`ctrl-t, ctrl-r`的shell快捷键.

### 参考信息

- [github fzf/readme.md: installation](https://github.com/junegunn/fzf#installation)

```plaintext
warning Key bindings (CTRL-T / CTRL-R / ALT-C) and fuzzy auto-completion may not be enabled by default.
```

### 解决方案

在fzf的git repository中有添加快捷键的脚本, 需要手动执行它.

```fish
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
```

## combining fzf with cd

> 2021.5.16

### 问题描述

Finding my working directories and cd into them waste a lot of time and cause distraction.  
I want to have kind of fuzzy jump feature.

### 参考信息

- [github ripgrep/issue: Feature request --directories](https://github.com/BurntSushi/ripgrep/issues/169)
- [github ripgrep/issue: Provide a --directories option to list directories](https://github.com/BurntSushi/ripgrep/issues/388)

### 解决方案

```fish
# file path: ~/.config/fish/functions/cdfzf.fish
function cdfzf
  cd (fd -H --type directory | fzf)
end
```

## fish shell 常见操作

- `fish`不兼容`bash`, 它更像是`csh`风格的
- `shift+tab`: fuzzy search completion
- `alt+s`: `sudo + {$last_command}`
- `alt+p`: `{$last_command} | {$env:pager}`
- `fish_config`
- `fish_update_completions`
- substitution `sudo pacman -Rns (pacman -Qdtq)`, `rm (fzf -m)`
- template string `echo {$var}`
- 用单引号包裹传递给程序的regex防止它被fish解析. `exa --all ~/.config | rg 'rc$'`

## fish shell: proxy settings

> date: 2021.1.13

### 问题描述

set/unset proxy environment variables in fish shell, and share them between sessions.

### 参考信息

- `fish -c help`
- fish shell official tutorial
- fish shell official documentation

1. `set --show VARIABLE_NAME`; `-x` for export; '-e' to erase; `-l,-g,-U; --local,--global,--universal` to specify scope;
2. universal: sort of permanent for the current user; shared between all the fish-shell-sessions; preserved even after reboot.
3. global: can shadow universal ones; not shared between fish-sessions; not preserved after reboot;
4. local: can shadow global ones;
5. `set -e VAR` delete the variable in the nearest scope where `VAR` is set.
6. `set -s VAR` show where is `VAR` defined and the value of it.
7. `set -q VAR` determine whether `VAR` is set.

**note**: fish will automatically load functions in `~/.config/fish/functions/`  

**fish shell have special ways to deal with PATH**, try `set --help` or `man fish set` for more information.

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

## keyboard shortcuts: terminal emulator, fish shell

- ctrl+Z: suspend (send `SIGTSTP`); jobs,fg,bg
- ctrl+P/N: select previous/next input history
- ctrl+L: clear the screen(just scroll the screen, won't clear previous output)
- ctrl+C: break (send `SIGINT` to the current foreground process)
- ctrl+D: send `EOF`

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

```plaintext
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

写入一些qt/gtk相关的环境变量我没有做,  首先我还在使用KDE,它能够较好的管理缩放,
其次是我发现进行了上面的配置之后,我常用的GUI apps已经正常缩放了.

## git: displaying unicode path

> 2021.03.24

git status, git commit中,中文路径显示不正确.
出现类似 `modified:   "\321\203\321\201\321\202\320\260\320\275\320\276\320\262"` 的提示信息.

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

```plaintext
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

```plaintext
[Login]
HandlePowerKey=suspend
```

## firefox usage: shortcuts

> currently on
>
> - `Linux x86_64`
> - firefox 87

- see [mozilla support: firefox shortcuts](https://support.mozilla.org/en-US/kb/keyboard-shortcuts-perform-firefox-tasks-quickly)
- see [mozilla support: firefox addr bar auto complet](https://support.mozilla.org/en-US/kb/address-bar-autocomplete-firefox)

### view

- `Ctrl+h` toggle sidebar:history
- `Ctrl+b` toggle sidebar:bookmarks
- `Ctrl+Shift+b` toggle bookmarks toolbar
- `Alt` toggle menu bar

### browsering

- `Ctrl +`,`Ctrl -` zoom in/zoom out
- `Ctrl+0` clear zoom
- `Alt+[1,2,3...8]` switching among tabs
- `Ctrl+Shift+PgUp` move the focus tab up
- `Ctrl+Shift+PgDn` move the focus tab down

### search bar

- `Ctrl+l` or `<F6>` focus the address bar(search bar, navigation bar)
- `Ctrl+j` or `Ctrl+k` search with default search engine
- `@{SE}` to search with specific search egine (`@bing osdi usenix`,`@wikipedia stokes theorem`)
- `^` search for browsing history.
- `*` search for bookmarks.
- `%` search for currently opened tabs.

### MISC

- `<F12>` or `Ctrl+Shift+I` open developer's toolkit
- `Ctrl+I` page info (media,permission,security)
- open library window
  - `Ctrl+Shift+h` history
  - `Ctrl+Shift+o` bookmark
  - `Ctrl+Shift+y` download
- `Ctrl+Shift+r` override cache, reload page

## i3wm focus到产生notification的windo

[i3wm faq: how to jump to urgent workspace](https://faq.i3wm.org/question/853/how-to-jump-to-urgent-workspace/index.html)

```plaintext
bindsym $mod+grave [urgent="latest"] focus
```

## xev: 查看 key-code和key-name

```fish
xev -event keyboard
```

## environment variable 环境变量

[arch wiki: env variables](https://wiki.archlinux.org/title/Environment_variables)

- shell configuration: `/etc/profile` global and `$HOME/.bashrc, $HOME/.config/fish/config.fish` per-user
- bash `export`, fish `set -x`
- PAM-env: `/etc/environment` global
- systemd.environment: `$HOME/.config/environment.d/{$name}.conf` per-user
- `~/.xinitrc`

run `/usr/bin/env` to show all environment variables

## qutebrowser setup

### resources

- `:help` [qutebrowser help page](https://qutebrowser.org/doc/help/)
- `:open qute://settings` or `:set`
- `$HOME/.config/qutebrowser`, `$HOME/.config/qutebrowser/config.py`
- [github/qutebrowser: user scripts](https://github.com/qutebrowser/qutebrowser/tree/master/misc/userscripts)

### keepassxc integration

[github/qutebrowser: qute-keepassxc](https://github.com/qutebrowser/qutebrowser/blob/master/misc/userscripts/qute-keepassxc)

1. enable browser extension in KeePassXC
2. install `python-pynacl` package
3. generate a GPG key pair `gpg --full-generate-key`
4. add key bindings in configuration
5. you may need to run `rm -f ~/.local/share/qutebrowser/keepassxc.key.gpg` and re-connect qutebrowser to KeePassXC.

```python
leader: str = ','
qutekey: str = 'B2D0D2EAB1C80196DA262CD9F019D7B44FB345C6'
config.bind(f'<Alt-p>',   f'spawn --userscript qute-keepassxc --key {qutekey}', mode='insert')
config.bind(f'{leader}p', f'spawn --userscript qute-keepassxc --key {qutekey}', mode='normal')
```

### gpu acceleration

[set qt flags for qutebrowser in config.py](https://github.com/qutebrowser/qutebrowser/discussions/6573)

```python
config.set(
    'qt.args',
    ['ignore-gpu-blacklist',
    'enable-gpu-rasterization',
    'enable-native-gpu-memory-buffers',
    'num-raster-threads=4',
    'enable-accelerated-video-decode'])
```

### basic operations

- `Ctrl+v` passthrough mode, all the key press are sent to the web page. (`shift+esc` go back to normal mode)
- `Escape` back to normal mode
- `v`,`Shift+v` caret (visual) mode, for selection and yanking. (`y`: copy and back to normal mode)

## tmux plugins

- [jdhao's blog: tmux plugin management](https://jdhao.github.io/2019/01/17/tmux_plugin_management/)
- [github/tpm](https://github.com/tmux-plugins/tpm)

reload tmux conf `tmux source ~/.tmux.conf`  

- `<prefix>+I` install plugins
- `<prefix>+u` update plugins
- `<prefix>+alt+u` uninstall plugins
