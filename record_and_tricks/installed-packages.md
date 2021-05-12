## installed software

### base

- distro: arch.
- DE/WM: kde plasma /i3wm
- DM: SDDM
- shell: fish
- terminal emulator: alacritty/konsole
- font-family: (Noto Sans CJK SC, Source Code Pro, Liberation Mono)
- package-manager: pacman(+pacman-contrib,pacutils),pac + yay(AUR manager) ; pip(python) ; cargo(rust) ; stack(haskell) ; tlmgr(texlive) ; npm(nodejs)  
  for global(system-wide) installation, use pacman. instead of pip/cargo/npm, so they get updated when running `pacman -Syu`, otherwise regularly manual update is required.
* GNU toolchain(compilers,linkers,debuger,build system...) (package group `base-devel` and package `gdb`)

### daily use

* fcitx5(with rime,rime-luna-pinyin)
* dolphin
* firefox
* okular
* LibreOffice
* ffmpeg,VLC,feh
* telegram
* kmail/thunderbird
* kolourpaint + GIMP + inkspace
* aspell

### working env

* NetworkManager+nmtui/nmcli
* iwd+iw/iwctl
* v2ray(gui frontend `qv2ray`; or `v2raya` for web fontend) + proxychains
* curl,wget,aria2,qBittorrent
* scrcpy
* keynav
* xclip
* rofi
* dunst
* screengrab

* tldr (see [github:tldr-pages](https://github.com/tldr-pages/tldr) and [tldr.sh](https://tldr.sh))
* tar,zip,gzip,bzip2,p7zip,zstd (+ gui-frontend ark)
* git
* rsync
* vim/neovim
* ranger,broot,exa
* fzf,rg,ag (FuzzyFileFinder, rip grep, the silver searcher)
* top/htop/bashtop

* texlive
* pandoc
* SageMath+Octave+Scipy(numpy,pandas,matplotlib,sympy) ~~and Tensorflow/PyTorch/sciket-learn~~
* graphviz


### MISC


* xorg-apps (`pacman -Sg xorg-apps`)
* pavucontrol+pactl (cli for pulseaudio)
* playerctl
* redshift
* ncdu
* trash-cli
* tmux
* syncthing
* **timeshift** (alternative: btrfs snapshot)
* screenkey+simplescreenrecorder


#### font-family

* noto fonts
* liberation fonts(for compatibility with `Arial/Times New Roman/Courier New`)
* source code pro

#### hardware status monitoring/diagnosing tool

* neofetch/screenfetch
* cpu-x (for hardware infomation and benchmark, resembles cpu-z on windows)
* s-tui (for cpu monitoring&stress cpu)
* radeontop (monitoring AMD GPU)
* lscpu,lspci,lshw,hwinfo,lsusb...
* wireshark, tcpdump
* smartmontools

### extensions/plugins for browser

* Cookie Quick Manager (cookies manipulation)
* Vimium (enabling vim-mode for browser)
* Dark Reader (for dark mode)
* User-Agent Switcher and Manager (changing user-agent field in the http request header)

