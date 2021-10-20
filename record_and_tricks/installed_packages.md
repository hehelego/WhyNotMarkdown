# installed software

[TOC]

## base

- distro: arch
- kernel: linux (the stable version)
- bootloader: grub
- init: systemd (the only offically supported init on arch linux)
- shell: fish
- package-manager: pacman (+ `pacman-contrib,pacutils`),  yay (AUR helper)
- GNU toolchain(compilers,linkers,debuger,build system...): `base-devel`
- DE/WM(backend: Xorg): i3wm(+compton compositor `picom`)/kde plasma
- DM: sddm
- fonts:
  - sans serif, serif: `noto-fonts,noto-fonts-{cjk,emoji,extra}`
  - monospace: `adobe-source-code-pro`,`ttf-liberation`,`ttf-hack`

## daily enviornment

- terminal emulator: alacritty
- input method: fcitx5(with `fcitx5-rime`,`fcitx5-configtool`)
- editor: vim,neovim,kate
- file manager: ranger,broot
- document viewer: okular (+ `poppler,poppler-data`)
- browser: firefox,qutebrowser
- mail client: thunderbird,kmail
- IM: telegram
- password manager: keepassxc

### networking

- networkmanager,nmtui,nmcli
- iwd,iw,iwctl
- nettools(for arp)
- ufw
- nmap(for nmap,ncat)
- v2ray(gui frontend `qv2ray`; or `v2raya` for web fontend)
- proxychains-ng
- curl,httpie
- wget,aria2
- openssh, sshfs

### CLI utilities

- coreutils, uutils-(the cross-platform rust rewriten version of coreutils)
- tmux
- git(TUI `lazygit`)
- rsync
- fzf,rg,ag(fuzzy file finder, rip grep, the silver searcher)
- top,htop,bashtop
- tar,7zip,zip,gzip,bzip (GUI frontend: `ark` from KDE project)
- man pages(`man-db,man-pages`)
- `tldr` (see [github:tldr-pages](https://github.com/tldr-pages/tldr) and [tldr.sh](https://tldr.sh))
- pandoc
- GnuPG
- openSSL
- age
- trash-cli
- ncdu
- lnav
- bat(alternative to coreutils/cat)
- delta(alternative to diffutils/diff)
- exa(alternative to coreutils/ls)
- fd(alternative to coreutils/find)
- procs(alternative to procps-ng/ps)
- zoxide
- jq,hq,yq (parse+prettyprint for json/html/xml/yaml)

### working

- python: pip,pipenv(pypi)
- node.js: npm(npmjs)
- rust: cargo(crates.io)
- haskell: stack(stackages,hackages)
- LaTeX: tlmgr(ctan)
- perl: cpan(cpan)

**notice:** (If it is possible) prefer packages in arch linux offical

- texlive
- make,cmake,clang
- sagemath+octave+scipy(`python-numpy`,`python-pandas`,`python-matplotlib`,`python-sympy`) ~~Tensorflow/PyTorch/sciket-learn~~
- hyperfine,perf,gprof,strace,valgrind

### other utilities

- rofi
- xorg-apps (`pacman -Sg xorg-apps`)
- redshift
- xclip
- klipper
- keynav
- dunst
- scrcpy
- kde connect
- dolphin
- syncthing, timeshift, btrfs snapshot
- SimpleScreenRecorder
- graphviz
- z3
- screengrab,spectacle
- simplescreenrecorder
- screenkey
- freerdp,xfreerdp(for connecting to a remote machine running windows)

## MISC

### uncategorized

- qBittorrent
- FOSS office alternative: LibreOffice
- spell checker: aspell

### social media

### multi media

- pavucontrol+pactl (cli for pulseaudio)
- playerctl
- ffmpeg
- VLC
- feh
- mpv (+ `mpv-mpris` for playerctl integration)
- kolourpaint + GIMP + inkspace
- exiv2
- mediainfo
- you-get

### font family

- google noto fonts (no tofu ~~不要豆腐~~, 字符集覆盖非常全)
- adobe source fonts (思源字体)
- liberation fonts (for compatibility with `Arial/Times New Roman/Courier New`, 提供windows上常见字体的兼容性)
- SourceCodePro, LiberationMono, NotoSansMono, Iosveka
- FontAwesome, NerdFonts

### hardware status monitoring/diagnosing tool

- neofetch/screenfetch
- s-tui (for cpu monitoring&stress cpu)
- radeontop (monitoring AMD GPU)
- lscpu,lspci,lshw,hwinfo,lsusb...
- wireshark, tcpdump
- smartmontools

### extensions/plugins for browser(firefox)

- Cookie Quick Manager
- vimium, surfingkeys, vixen
- Dark Reader
- User-Agent Switcher and Manager
- uBlock origin
- privacy badger
- sidebery
