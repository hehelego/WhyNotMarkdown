# installed software

[TOC]

## base

- distro: arch
- kernel: linux (the stable version)
- bootloader: grub
- init: systemd (the only offically supported init on arch linux)
- shell: fish
- package-manager: pacman (additional packages `pacman-contrib,pacutils`), yay (AUR helper)
- GNU toolchain (compilers,linkers,debuger,build system...): `base-devel`
- DE/WM (backend: Xorg/Wayland): i3wm (need a X compositor `picom`)/KDE plasma/sway
- DM: sddm
- fonts:
  - sans serif, serif: `noto-fonts` (packages: `noto-fonts-{cjk,emoji,extra}`)
  - monospace: `adobe-source-code-pro`,`ttf-liberation`,`ttf-hack`

## daily enviornment

- terminal emulator: alacritty
- input method: fcitx5 framework + rime input method
- editor: vim,neovim,kate
- file manager: ranger,broot
- document viewer: okular (requires `poppler,poppler-data`)
- calibre: ebook manager and converter
- browser: firefox,qutebrowser
- mail client: thunderbird,kmail
- IM: telegram
- password manager: keepassxc

### networking

- networkmanager,nmtui,nmcli
- iwd,iw,iwctl
- nettools (for arp)
- ufw
- openssh, sshfs
- curl,httpie
- wget,aria2
- nmap (for nmap,ncat)
- v2ray (frontend `qv2ray` or `v2raya`)
- proxychains-ng

### CLI utilities

- tmux
- git(TUI `lazygit`)
- GnuPG
- rsync
- fzf,rg,ag + ripgrep-all (`skim` rust implementation of fzf)
- top,htop,bashtop
- tar,7zip,zip,gzip,bzip (GUI frontend `ark` from KDE project)
- man pages(`man-db,man-pages`)
- tldr pages (see [github:tldr-pages](https://github.com/tldr-pages/tldr) and [tldr.sh](https://tldr.sh))
- openSSL, age (see [github:age](https://github.com/FiloSottile/age)), rage (rust implementation of age)
- trash-cli
- lnav
- bat (alternative to coreutils/cat)
- delta (alternative to diffutils/diff)
- exa (alternative to coreutils/ls)
- fd (alternative to coreutils/find)
- procs (alternative to procps-ng/ps)
- duf (alternative to coreutils/df)
- dust (alternative to coreutils/du)
- ncdu (ncurses TUI du)
- zoxide (see [github:zoxide](https://github.com/ajeetdsouza/zoxide))
- starship (see [starship.rs](https://starship.rs/) and [github:starship](https://github.com/starship/starship))
- pandoc
- jq,hq,yq (parse/pretty/extract/convert for json/html/xml/yaml)

### working

- python: pip,pipenv (pypi)
- node.js: npm (npmjs)
- rust: cargo (crates.io)
- haskell: stack (stackages,hackages)
- LaTeX: TeXLive distribution, tlmgr (ctan)
- perl: cpan (cpan)

**notice:** (If it is possible) prefer packages in arch linux offical

- make,cmake,meson
- clang, clangd, ccls
- sagemath,octave
- scientific python eco-system (`scipy`,`numpy`,`pandas`,`matplotlib`,`seaborn`,`sympy`; `TensorFlow`,`PyTorch`,`mxnet`)
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
- ydcv: [ydcv-rs](https://github.com/farseerfc/ydcv-rs), [ORIGINAL ydcv](https://github.com/felixonmars/ydcv/)

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
