# installed software

[TOC]

## base

- distro: arch
- kernel: linux (the stable version)
- init: systemd (the only offically supported init on arch linux)
- shell: fish
- package-manager:  
  pacman (+pacman-contrib,pacutils),  
  yay (AUR helper)  
  pip(python), npm(node.js), cargo(rust), stack(haskell), tlmgr(texlive)  
  **notice:** (If it is possible) prefer packages in arch linux offical
  repositories to packages from pip/cargo/npm.
- GNU toolchain(compilers,linkers,debuger,build system...): `base-devel`,`gdb`

## my working enviornment

- DE/WM(backend: Xorg): i3wm(+compton compositor `picom`)/kde plasma
- DM: SDDM
- font-family:
  - sans serif, serif: google-noto-fonts/adobe-source-fonts
  - monospace: adobe-source-code-pro
- terminal emulator: alacritty/konsole
- input method: fcitx5(with rime,rime-luna-pinyin)
- editor: vim/neovim
- file manager: ranger,broot,exa
- document viewer: okular
- browser: firefox
- mail client: thunderbird, kmail
- im: telegram

### important ones

- coreutils, rust-coreutils
- tmux
- rofi
- v2ray(gui frontend `qv2ray`; or `v2raya` for web fontend) + proxychains
- NetworkManager+nmtui/nmcli
- iwd+iw/iwctl
- curl,wget,aria2
- git
- make,cmake
- rsync
- fzf,rg,ag (FuzzyFileFinder, rip grep, the silver searcher)
- top/htop/bashtop
- tar,zip,gzip,bzip (GUI frontend: `ark` from KDE project)
- tldr (see [github:tldr-pages](https://github.com/tldr-pages/tldr) and [tldr.sh](https://tldr.sh))
- texlive
- pandoc
- SageMath+Octave+Scipy(numpy,pandas,matplotlib,sympy) ~~and Tensorflow/PyTorch/sciket-learn~~
- GnuPG
- openSSL
- age

### other utilities

- trash-cli
- ncdu
- xorg-apps (`pacman -Sg xorg-apps`)
- redshift
- screengrab
- xclip
- klipper
- keynav
- lazygit
- dunst
- scrcpy
- kde connect
- dolphin
- syncthing, timeshift, btrfs snapshot
- screenkey
- SimpleScreenRecorder
- graphviz

## MISC

### uncategorized

- qBittorrent
- FOSS office alternative: LibreOffice
- spell checker: aspell

### social media

### multi media

- pavucontrol+pactl (cli for pulseaudio)
- playerctl
- ffmpeg,VLC,feh
- kolourpaint + GIMP + inkspace
- exiv2
- mediainfo

### font family

- google noto fonts (no tofu ~~不要豆腐~~, 字符集覆盖非常全)
- adobe source fonts (思源字体)
- liberation fonts (for compatibility with `Arial/Times New Roman/Courier New`, 提供windows上常见字体的兼容性)
- SourceCodePro, LiberationMono, NotoSansMono, Iosveka
- FontAwesome, NerdFonts

### hardware status monitoring/diagnosing tool

- neofetch/screenfetch
- cpu-x (for hardware infomation and benchmark, resembles cpu-z on windows)
- s-tui (for cpu monitoring&stress cpu)
- radeontop (monitoring AMD GPU)
- lscpu,lspci,lshw,hwinfo,lsusb...
- wireshark, tcpdump
- smartmontools

### extensions/plugins for browser

- Cookie Quick Manager
- Vimium
- Dark Reader
- User-Agent Switcher and Manager
