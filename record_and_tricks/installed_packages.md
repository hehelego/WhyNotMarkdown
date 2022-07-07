# installed software

[TOC]

## base

- installer and reproducible installation: `archinstall`
- distro: Arch Linux
- kernel: `linux` (the stable version)
- bootloader: `systemd-boot` (CLI `/usr/bin/bootctl`) (replacing `grub`)
- init: `systemd` (the only officially supported init system on Arch Linus)
- shell: `fish`
- package-manager: `pacman`(with `pacman-contrib` and `pacutils`), `yay` (an AUR helper)
- GNU tool chain: `base-devel` (compiler, assembler, linker, loader, debugger, build system...)
- display server protocol: Wayland/X11 
- display manager: `sddm`
- desktop environment or window manager: `i3-wm` + `picom` or `sway` or `qtile`
- terminal emulator: `alacritty`, `wezterm`
- editor: `neovim`; additional ones `helix`, `kakoune`, `vscodium`
- configuration/dotfiles manager: `chezmoi`
- version control: `git`(TUI `lazygit`, `gitui`; github CLI `gh`)
- terminal multiplexer: `tmux`

## daily environment

- input method: fcitx5 framework + rime input method (`fcitx5` group and `fcitx5-rime`)
- document viewer: `okular` (with `poppler, poppler-data`)
- e-book manager/converter: `calibre`
- note-taking: `vnote`
- browser: `firefox`, `qutebrowser`
- email/calendar/RSS: `thunderbird`, `kmail`
- password manager: `keepassxc`
- messaging: `telegram-desktop`
- document converter: `pandoc`
- multimedia: `ffmpeg`,`vlc`,`mpv`,`feh`,`viu`


### network accessing

- `networkmanager`: provides `/usr/bin/{nmtui,nmcli}`
- `iwd`: provides `/usr/bin/{iwd,iwctl}`
- `nettools`: for `/usr/bin/arp`
- `ufw`: firewall
- `openssh`, `sshfs`
- `curl`, `httpie`
- `wget`, `aria2`
- `nmap`: provides `/usr/bin/{nmap,ncat}`
- `v2ray`: frontend `v2raya`
- `proxychains-ng`
- network traffic analyzer: `wireshark`, `tcpdump`

### CLI utilities

- crypto tools:
  - OpenPGP `gnupg`
  - age encryption protocol: `rust-rage`, `age`
  - OpenSSL toolkit: `openssl`
- file transfer: `rsync`
- file manager: `ranger`, `ncdu`
- regex/fuzzy searcher: `fzf`,`ripgrep, ripgrep-all`,`fselect`,`the_silver_searcher`
- accessing archives and compressed files: `tar`,`zip/unzip`,`bzip2`,`p7zip`,`gzip`,`xz`,`zstd`,`unrar`; `ark` for GUI
- man pages: `man-db, man-pages`
- tldr pages: `tldr`
- CLI to free-desktop recycle bin: `trash-cli`
- system services managing: `systemd` (provides `/usr/bin/systemctl`),`lnav`,`sysz`
- fish shell prompt: `starship`
- `pueue`: managing long-running shell command
- modern CLI/TUI utilities and replacement for `coreutils`
  - `zoxide`: alternative to `autojump`
  - `exa`: alternative to `coreutils/ls`
  - `bat`: alternative to `coreutils/cat`
  - `fd`: alternative to `coreutils/find`
  - `delta`: alternative to `diffutils/diff` (**NOTE**: `delta` can not produce patches)
  - `procs`: alternative to `procps-ng/ps`
  - `duf`: alternative to `coreutils/df`
  - `dust`: alternative to `coreutils/du`
  - `sd`: alternative to `sed` and `gawk`

### working

- programming language tool chain
  - C/C++
  - Python
  - Rust
  - Haskell
  - Node.js
- LaTeX: `texlive-{most,lang}` group; `biber`; `tllocalmgr`
- Mathematical software: `sagemath`, `octave`
- scientific python ecosystem:
  - `python-{scipy,numpy,sympy}`
  - `python-{matplotlib,seaborn}`
  - `python-pandas`
- profiler, debugger, tracer and monitor
  - `gdb`, `lldb`: the common debugger
  - `hyperfine`: measuring program runtime
  - `perf`: performance audit tool provided by Linux kernel
  - `strace`: tracing system calls
  - `valgrind`: memory leak detector
  - `lsof`: list all opened files
  - `htop,bashtop,bpytop,btop`: resources (processes, network, disks, memory) monitor
  - `iotop`: I/O usage monitor
  - `powertop`: power consumption monitor
  - `s-tui`: CPU usage monitor
  - `radeontop`, `nvtop`: GPU usage monitor for AMD/Nvidia graphics cards

### other utilities

- `xdg-utils` (provides `/usr/bin/xdg-{mime,open}`)
- x11 applications: `xorg-apps` group
- program launcher: `rofi`
- display color temperature adjustment: `redshift`; `gammastep`
- system-wide desktop clipboard: `xclip`; `wl-clipboard`
- replace mouse with your keyboard: `keynav`, `warpd`
- desktop notification center: `dunst`
- controlling android devices: `scrcpy`
- connecting with smartphone: `kdeconnect`
- GUI file explorer: `dolphin`
- disk snapshot and recovering: `syncthing`, `timeshift`, `btrfs-prog`
- screen video recording: `simplescreenrecorder`
- terminal text recording: `asciinema`
- visualizing topological graphs:`graphviz`
- screenshot: `flameshot`, `spectacle`; `grim+slurp`
- display the keyboard actions: `screenkey`; `showmethekey`
- RDP and VNC support: `freerdp`
- dictionary lookup: `ydcv-rs`

## MISC

### uncategorized

- BitTorrent client: `qbittorrent`
- FOSS office suite: `local/libreoffice-fresh`
- spell checker: `aspell`, `hunspell`

### multimedia tools

- audio server: `pipewire` (replacing `pulseaudio`)
- volume control: `/usr/bin/pactl`, `kmix`
- media player controlling: `playerctl`
- graphics drawing: `kolourpaint` + `gimp` + `inkspace`
- metadata tools
  - `mediainfo`
  - `exiv2`
- `you-get`


### font family

- Google noto (no tofu ~~不要豆腐~~, 字符集覆盖非常全) (`noto-fonts-{cjk,emoji,extra}`)
- Adobe source code pro (`adobe-source-code-pro`)
- The hack fonts (`ttf-hack`,`nerd-fonts-hack`)
- The iosevka fonts (`ttf-iosevka-nerd`)
- The liberation fonts (replacing windows fonts such as `Arial,Times New Roman,Courier New`)
- The fandol fonts (`otf-fandol`, basic Chinese typesettings: Song/Hei/Kai/Fang)
- display icons: nerd fonts, font awesome

### hardware status monitoring/diagnosing tool

- `neofetch`
- `/usr/bin/{lscpu,lspci,lshw}`
- `hwinfo`
- `lsusb`
- `smartmontools`
