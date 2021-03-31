## installed software

### base

> distro: arch  
> env: kde/i3wm
> shell: fish  
> terminal-emulator: alacritty/konsole  
> font-family: (Noto Sans CJK SC,Source Code Pro,Liberation Mono)
>
> package-manager: pacman(+pacman-contrib,pacutils),pac + yay(AUR manager) ; pip(python) ; cargo(rust) ; stack(haskell) ; tlmgr(texlive) ; npm(nodejs)

### daily use

* fcitx5(with rime,rime-luna-pinyin)
* ark,p7z (compressing/decompressing archives)
* dolphin
* firefox
* okular
* LibreOffice
* ffmpeg,VLC,feh
* telegram
* kmail
* kolourpaint + GIMP + inkspace
* aspell

### working

* v2ray(gui frontend `qv2ray`; or `v2raya` for web fontend) + proxychains-ng
* curl,wget,aria2
* keynav
* xclip

* tldr (see [github:tldr-pages](https://github.com/tldr-pages/tldr) and [tldr.sh](https://tldr.sh))
* rofi
* GNU toolchain(compilers,linkers,debuger,build system...) (package group `base-devel` and package `gdb`)
* git
* vim/neovim
* ranger,broot,exa
* top/htop/bashtop
* fzf,rg,ag (FuzzyFileFinder, rip grep, the silver searcher)
* rsync

* texlive
* pandoc
* SageMath+Octave+Scipy(numpy,pandas,matplotlib,sympy) ~~and Tensorflow/PyTorch/sciket-learn~~

**for global(system-wide) installation,use pacman. instead of pip/cargo/npm** (so that `pacman -Syu` will update them, otherwise manually update is required)  

* python(package `python`,`python-pip`,`python-pipenv`) + `python-ipython`
* MISC
  * nodejs (package `nodejs,npm`)
  * rust (package `rust`)
  * haskell (package `ghc`)
  * racket,coq,agda,idris...


### MISC


* noto fonts, liberation fonts, source code pro
* xorg-apps (`pacman -Sg xorg-apps`)
* tmux
* dunst
* smarttools
* graphviz
* scrcpy
* qemu(请参考[octetz写的一篇关于qemu的博客](https://octetz.com/docs/2020/2020-05-06-linux-hypervisor-setup/),以及arch wiki进行操作)
* qBittorrent
* syncthing
* **timeshift**
* tox(`qtox`/`utox` for gui frontend)
* screenkey+simplescreenrecorder
* screengrab

* ncdu
* NetworkManager+nmtui/nmcli
* iwd+iw/iwctl
* pavucontrol+pactl (cli for pulseaudio)
* playerctl
* trash-cli

* neofetch/screenfetch
* cpu-x (for hardware infomation and benchmark)
* s-tui (cpu monitoring&stress cpu)
* radeontop (monitoring AMD GPU)
* lscpu,lspci,lshw,lsusb 更相信的硬件信息

### extensions/plugins for browser

* Cookie Quick Manager (cookies manipulation)
* Vimium (enabling vim-mode for browser)
* Dark Reader (for dark mode)
* User-Agent Switcher and Manager (changing user-agent field in the http request header)

