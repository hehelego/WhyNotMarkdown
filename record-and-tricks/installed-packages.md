## installed software

### base

> distro: manjaro/arch  
> de: kde / wm: i3
> shell: fish  
> terminal-emulator: alacritty/konsole  
> font-family: (Noto Sans CJK SC,Source Code Pro,Liberation Mono)
>
> package-manager: pacman(+pacman-contrib,pacutils),pac + yay(AUR manager) ; pip(python) ; cargo(rust) ; stack(haskell) ; tlmgr(texlive) ; npm(nodejs)

### daily use

* fcitx5(with rime,rime-luna-pinyin)
* 7zip(gui frontend:ark,gnome archive manager)
* firefox
* dolphin
* okular
* LibreOffice
* ffmpeg
* VLC
* telegram
* kmail
* kolourpaint + GIMP + inkspace
* aspell

### working

* v2ray(gui frontend `qv2ray`) + proxychains-ng

* GNU toolchain(compilers,linkers,debuger,build system...) (package group `base-devel` and package `gdb`)
* git
* vim/neovim(with vim-plug,**coc.nvim**)
* ranger
* broot
* top/htop/bashtop
* fzf
* ripgrep
* `the_silver_search/ag`(a code-searching tool)
* tmux
* tldr
* rsync
* rofi

* texlive
* pandoc
* typora(opensource alternatives: vnote,marktext)
* SageMath+Octave+Scipy(numpy,pandas,matplotlib,sympy) ~~and Tensorflow/PyTorch/sciket-learn~~

**for global(system-wide) installation,use pacman. instead of pip/cargo/npm** (so that `pacman -Syu` will update them, otherwise manually update is required)  

* python(package `python`,`python-pip`,`python-pipenv`)
* jupyter/ipython/bpython
* MISC
  * nodejs(nodejs,npm)
  * rust(rustup,cargo)
  * haskell(ghcup,stack,cabal-install)
  * racket(racket,DrRacket)
  * coq,agda,idris


### MISC


* keynav
* graphviz
* scrcpy
* qemu,virtualbox(请参考[octetz写的一篇关于qemu的博客](https://octetz.com/docs/2020/2020-05-06-linux-hypervisor-setup/),以及arch wiki进行操作)
* curl,wget,aria2
* qBittorrent
* syncthing
* **timeshift**

* ncdu
* NetworkManager+nmtui/nmcli
* iwd+iwctl
* screenkey+simplescreenrecorder+kdenlive

* neofetch/screenfetch
* cpu-x(for hardware infomation and benchmark)
* s-tui(cpu monitoring&stress cpu)
* radeontop(monitoring AMD GPU)
* lscpu,lspci,lshw,lsusb 更相信的硬件信息

* you-get (pypi | community/you-get)
* coursera-dl (pypi | community/coursera-dl)
* BILIdrive+CDNdrive (pypi. 把公共cdn当成云盘,数据安全警告)

### extensions/plugins for browser

* tampermonkey
* oneTab
* auto discard tab
* cookie quick manager(on firefox)
* vimium(vim-mode on firefox)



