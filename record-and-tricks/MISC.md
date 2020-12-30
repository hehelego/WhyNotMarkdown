> ~~这是我作为一名长者,给你们的人生经验~~


- 多看arch wiki/manjaro wiki,多去forum找找解决方案. 网速不够可以试试tuna/sjtug/ustc/aliyun/huawei mirror,以及github/gitlab难以访问时尝试gitee(码云).
- 虽然linux distro和windows不一样,不用经常reboot,但是reboot还是一个能解决不少问题的方法...当然有时候logout一下再回来,重启一下DE/WM就好了..
- manjaro是滚动发行版,可能出现新问题,旧问题可能被消除,解决方案可能会失效,尽量自己找第一手信息.
- manjaro特色之一: mhwd,有`mhwd-tui,mhwd`分别对应TUI和CLI,可以轻松配置driver,kernel.
- 换中国境内的软件源`sudo pacman-mirrors -i -c China -m rank`,也可以和arch一样直接编辑`/etc/pacman.conf /etc/pacman.d/mirrorlist`全球镜像列表自行去manjaro/arch官网找.
- [ban掉烦人的beep](https://wiki.archlinux.org/index.php/PC_speaker):在`/etc/modprobe.d/nobeep.conf`写入`blacklist pcspkr`之后reboot即可.
- ==(输入法看这里)==推荐使用fcitx5框架,rime输入法,luna-pinyin. 参考[archwiki:fcitx5](https://wiki.archlinux.org/index.php/Fcitx5)进行安装,配置即可.  
  使用rime时可以按`<F4>`快速进行配置(简体繁体转化,全角半角转换等).
- 使用wine,参考[arch wiki:wine](https://wiki.archlinux.org/index.php/Wine)
	- 安装`wine wine-mono wine-gecko winetricks`.
	- 使用`WINEPREFIX=${path-to-container} WINEARCH={win32,win64} command`指定容器位置和wine运行时架构,默认是`WINEPREFIX~/.wine WINEARCH=win64`.
	- 使用`wine a-program-built-for-windows.exe`来运行windows应用.
	- 使用`winecfg`和`wine regedit`(如上配合环境变量设置)对wine进行设置,以及调整注册表.
	- 需要先做个字体替换才能正常玩
	- 出现 框框字 问号字 古文字 等等...是字体读取的问题,在命令前面加入`env LC_ALL=zh_CN.gbk / env LC_ALL=zh_CN.UTF-8`即可.
- 关于wine qq/wechat/tim不能查看图片(2020.7.16)
  - ipv6有一点问题,导致连不上腾讯的图片cdn,需要做一个本机的http proxy.
  - 安装`privoxy`,之后`systemctl enable,start`启动服务(manjaro的init是systemd,不是用systemd的话略有区别).
  - qq/wechat/tim登陆的时候配置http代理.默认是`http://127.0.0.1:8118`
  - 有其他问题,自行查阅`man privoxy`查找对应的配置文件进行修改...
  - 请自行找`/etc/privoxy/config`里面的内容过滤,搜素`toggle`把它们都关掉.
  - 还不行的话只能暂时禁用ipv6...或者virtualbox装个windows虚拟机跑了.
- ==(DE/WM字体配置看这里)==需要调整fontconfig,locale,参考arch wiki.也可以在DE的`system settings`中直接设置.  
  **对于manjaro-kde用户而言,可以不用任何配置直接使用;CJK fonts fallback需要手动设置一下,让SC优先级高于JP即可(参考arch wiki)**  
- 字体配置推荐,无脑`Noto Sans CJK Sc`即可,个人体验来讲`Noto Sans`比`Source Sans`好一些,`Serif`字体不太习惯.对于等宽的编程字体,推荐`Source Code Pro`和`Liberation Mono`.具体而言`noto-fonts,noto-fonts-{cjk,emoji,extra,compat}`
<<<<<<< HEAD
- 中文字体(CJK-SC)fallback到日文字体,解决方法参考[menci在zhihu上面的这个回答](https://www.zhihu.com/question/47141667).  
  > `sudo vim /etc/fonts/conf.d/64-language-selector-prefer.conf `  
  > ```xml
  > 	<!DOCTYPE fontconfig SYSTEM "fonts.dtd">
  > 	<fontconfig>
  > 		<alias>
  > 			<family>sans-serif</family>
  > 			<prefer>
  > 				<family>Noto Sans CJK SC</family>
  > 				<family>Noto Sans CJK TC</family>
  > 				<family>Noto Sans CJK JP</family>
  > 			</prefer>
  > 		</alias>
  > 		<alias>
  > 			<family>monospace</family>
  > 			<prefer>
  > 				<family>Noto Sans Mono CJK SC</family>
  > 				<family>Noto Sans Mono CJK TC</family>
  > 				<family>Noto Sans Mono CJK JP</family>
  > 			</prefer>
  > 		</alias>
  >	</fontconfig>
  > ```


- KDE中`display>scaling`缩放,如果不是整数倍则会有bug.屏幕上可能会无端出现一根白线,并且icon及font的渲染都会有问题.
- 选择困难症?不妨看看[arch wiki:general recommendation](),[arch wiki:List of applications/Utilities]()
- 关于fish shell的一些事情
  - fish shell有些配置是不兼容bash的,比如path,manpath之类的,他的配置文件是`~/.config/fish/config.fish`配置的语法也和bash不同...尽量不要用`set -U VAR, set -g VAR`这种会影响全局配置甚至其他shell的配置.
  - bash中的`pacman -S $(cat softwarelist)`在fish中是`pacman -S (cat softwarelist)`.更常见的例子:`rm $(fzf -m)`应替换为`rm (fzf -m)`.
  - 中fish中一些regex的语法和fish shell的语法有冲突,使用单引号来标识他们,比如查询以rc结尾的配置文件应该这么写`ls ~/.config/ | grep 'rc$'`.
- 关于pandoc+xelatex下的`markdown+latex -> tex -> pdf`工作流.
  - 需要修改pandoc的转换模板,使得`markdown->tex`时具有正常的文档结构和设定的常用包以及字体配置.
  - 推荐使用[link:Eisvogel](https://github.com/Wandmalfarbe/pandoc-latex-template)这个LaTeX模板.参考他们的readme就可以正常使用了(参考命令`pandoc note.md -o book.pdf  --template eisvogel --listings --pdf-engine=xelatex`).我把我定制的eisvogel模板,以及编译脚本都放到了staic目录下面
  - 这里因为`tex->pdf`是LaTeX提供的,所以比mathjax的语法要求要强一些,版本升级会产生语法不向后兼容的问题,请自行查找资料或询问网友.
  - 我自己用的转换脚本,模板文件都装`github/hehelego/whynotmarkdown`里面有.
- how to show installed AUR packages? `pacman -Qm / pacman -Q --foreign`,原理如下.  

> Restrict or filter output to packages that were not found in the sync database(s). Typically these are packages that were downloaded manually and installed
with --upgrade.

- 比较新的gdb中加入了`layout src`,`highlighting`,`struct pretty print`等features,使用更加便捷了,此外还有cgdb这个前端,更加方便易用.
- [v2ray proxy配置](https://qv2ray.net/),[github:qv2ray](https://github.com/Qv2ray/Qv2ray),[github:qv2ray-docs](https://github.com/Qv2ray/qv2ray.github.io)几乎是无脑配置. 代理路线推荐`JustMySocks`,国内有人做镜像/反响代理站可以正常访问,而且支持`Alipay(支付宝)`付款.
- ipython crash on tab completion:[refer to this issue](https://github.com/ipython/ipython/issues/12522) 更新到`ipython>=7.18.1`即可.
  如果一个pypi的包是用`pacman`装的,`sudo pacman -Syyu`可以更新,但是用`pip`安装的并不会,需要自己时常手动更新,以及尽量不要全局安装,避免依赖版本冲突(推荐pipenv).`pip list --outdated`来查询可以更新的包.
- 关于cpu turbo boost失效: 向`/sys/devices/system/cpu/cpufreq/boost`中写入1开启boost.
- 关于backlight调节: 修改`/sys/class/backlight/{amdgpu_bl0}/brightness`



- jobs,fg,bg,ctrl+D,ctrl+Z,ctrl+C

> - ctrl+P/N: select previous/next input history
> - ctrl+L: clear the screen(just scroll the screen, won't clear previous output)
> - ctrl+C: break(send `SIGINT` to the current foreground process)
> - ctrl+D: `EOF`(send EOF to stdin)
> - ctrl+Z: suspend(send `SIGTSTP`)
> - jobs/bg/fg: show current jobs;resume one suspended job in the backgroud;resume one suspended job in the foreground (for fish shell,try `fg nvim+<TAB>` to resume neovim)



- 关于i3(或者sway)  
	- 目前(2020年11月)wayland还不是完全可用,并且生态也没有完全构建起来,与X的兼容方案Xwayland也有不少严重bug. 所以可以等等,但是发展趋势还是不错的.
	- 平铺窗口管理器中,i3/sway是我最喜欢的. 文档清晰,配置简洁.  
	- 推荐使用一个display manager来管理desktop session而不是直接startx/xinit启动.来自KDE的SDDM非常棒,我目前使用的是它.
	- i3是没有compositor,需要自己搞一个,推荐compton(现在是picom). sway则不需要这些.  
	- 需要其他软件来显示桌面壁纸,目前i3可以选择feh,而sway有swaybg.
	- 需要另外搞一个application launcher,可以选krunner,albert,rofi等.
	- 默认的status bar可能不太够用,可以试试polybar,swaybar
	- 高分辨率需要调节DPI,scaling等参数. 查arch wiki,i3 user manual以及各种forum即可.
	- i3lock直接用效果不好,也没有自动休眠之类的东西...可以自己写脚本来解决,但是比较困难. 
	- i3的`$mod+h,$mod+v`用来控制分屏方式,所以移动`hjkl`缺了一个键,推荐不用`jkl;`,直接使用方向键即可(如果是67键的键盘就比较困难了... )
	- 慎用`exec_always`...



