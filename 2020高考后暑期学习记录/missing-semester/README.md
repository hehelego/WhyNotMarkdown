# note on *The Missing Semester of Your CS Education*

## about
- 这并不是一门真正的完整课程,而是一系列关于工具使用的讲座.
- [official site of the course](https://missing.csail.mit.edu/),[github](https://github.com/missing-semester/missing-semester)
- [2020 version](https://missing.csail.mit.edu/2020/),[2019 version](https://missing.csail.mit.edu/2019/) 内容有些差异,有空可以都看看.
- [videos,on bilibili](https://www.bilibili.com/video/BV1x7411H7wa)  
- ~~学习这个课程主要是为了适应英文授课~~.
- 我的环境是manjaro linux(a awesome distro based on arch linux).终端模拟器为alacritty(或者kde的konsole).shell为fish.

## overview
你是不是还在手动敲一堆命令,进行重复性工作?随便从网上复制粘贴一个脚本?遇到错误只能求助stack overflow?   
这门课程尝试帮你解决它们.  

课程由11个长度为1小时的讲座构成,每次课都会有一些帮你掌握要点的练习.  
每次课后有office hours,帮助学生们解决疑难杂症 ~~虽然我们不在MIT体验不到~~ ,线上学习的网友们可以把问题发到[missing-semester@mit.edu](missing-semester@mit.edu).  

课程时间有限,无法在每个工具的介绍中深入细节,但是他们会尽量给出可以供你深挖的学习资源.  

$$\pagebreak$$

## Topic 1: the shell  
- When it comes to the `shell`, i prefer the `fish shell:Friendly Interactive SHell`.
- And the terminal emulator which I am currently using is called `alacritty`.


图形化,语音交互,甚至VR/AR的交互方式确实很方便,但是他们的功能有限.  

> To take full advantage of the tools your computer provides,  
> we have to go old-school and drop down to a textual interface: The Shell.

GUI应用目前还无法完全取代TUI和CLI应用,所以,让我们开始学习使用shell吧.  

使用shell工作的特点是:  

- interactiv(当然也可以有scripting)
- plain text(当然现代的shell+terminal emulator可以一定程度地使rich text,比如有趣的python库rich),unstructured.
- using CLI,TUI rather than GUI
- UNIX哲学:KISS(不要大而全,考虑小而精+易于组合的应用).比如使用redirection而不是把源/目标文件当作参数,使用pipe来组合操作.**阅读wikipedia,arch wiki获取更多更全的关于KISS的内涵与解读**
- 一切皆为文件(任何一个应用不正是由I/O与数据处理组成的吗?只不过数据的来源,类型,特点以及输出方式有所不同罢了).可以去`/sys/class/backlight/intel_backlight`看看,并且尝试修改其中的文件,看看会发生神秘.


> shell(尤其是年迈的bash)问题很多,比如没有类型检查(影响脚本编程,也影响了pipe的使用,有些时候structured,typed是必要的);比如空格分开参数;又比如程序调用,pipe,redirection的优先级,结合律不清晰;还有最广为人知的滥用template string.而且较为现代的shell(比如zsh,fish,posh-powersshell)也没有彻底解决这些问题.  
> **所以shell的这个设计思维这个工作方式并不完美,甚至可以说问题非常多.但是,取其精华去其糟粕嘛.我们学习那种设计思维与工作方式以便提升工作效率;并且留意那些不完美甚至垃圾的设计,了解其成因和解决方案,在自己未来设计与实现程序时努力避免.**


prompt:大概这个样子
```plaintext
pinach@spinach-latitude5480 ~>
[spinach@spinach-latitude5480 ~]$
[spinach-latitude5480 ~]#
```
第一个是fish,后面两个是bash,默认状态下在用户家目录的提示符.  
前面的部分是`user@host`,如果你使用过ssh的话应该会记得`ssh spinach@127.0.0.1 -p22`
`$,#`告诉你现在使用的是普通用户还是root.  

path:比如`.`,`../`,`/home/spinach/`,以及`~/workspace/git-repos/WhyNotMarkdown/`  
linux中,`dot files`(就是文件名是.开头的文件)是隐藏问题,试试`ls -lah`来查看它们吧.  
路径用`/`进行分割,目录名可以含有空格,但是由于shell使用`application arg0 arg1 arg2 ...`的语法进行调用,所以需要用引号包裹路径防止被识别为两个参数(可以看看下面这三个等价的例子).  
使用pwd输出绝对路径(不过有个东西叫chroot).  

```bash
# create an empty file called "my birthday"(without the bracket/parenthese)
echo 19260817 > 'my birthday'
echo 19260817 > "my birthday"
echo 19260817 > my\ birthday
```

常用的东西
```bash
echo
which
whoami
cd,ls,pwd
touch,mkdir
cp,mv
xdg-open
cat,tee
man
sudo
chmod,chown
jobs,fg,bg,(Ctrl+Z)
clear,(Ctrl+L)
(Ctrl+C)
history
grep
less
env
```

关于用户,用户组,权限:使用`ls -lah`会有一些而`rwx-`组成的长度为9的字符出.  
每3个字符是一组,三组分别表示:所有者权限,所属组的权限,所有其他用户的权限.  
rwx的意义很明显了,就是read write execute(如果这个文件是个目录,w 在其中添加删除文件(modify),x 是否可以深入这个目录(search),r 获取目录下的内容)  



几个有趣的例子.
```bash
$ ls -l / |sort| tail -n1
> -rw-r--r--   1 root root  5037  6月  6 17:01 rootfs-pkgs.txt
$ ls -l / |sort|  head -n1
> 总用量 92
> spinach@spinach-latitude5480 ~/w/g/W/2/missing-semester (master)> ls -l / |sort|  head -n2

$ curl --head --silent https://www.bing.com | grep --ignore-case content-length | cut --delimiter=' ' -f2
> 137
```

下面这个例子,演示了shell中pipe,redirection的一些特性(或许可以称之为,非侵入式).  
被pipe,redirection操作的程序,并不会直接互相通信,这个数据传输的工作是shell进行的,所以用sudo暂时获取的root权限并不能被下一个程序使用.  
因为pipe仅仅是shell拿了一个程序的输入,给到另一个程序作为输入,中间没有任何其他工作.  
redirection类似,也是shell建立的,而不是这个程序本身进行来redirection
```bash
$ sudo touch try-modify
$ ls -lah
> -rw-r--r-- 1 root root 0  8月 16 22:17 try-modify
$ sudo echo qwq > try-modify
> sh: try-modify: Permission denied
$ sudo echo qwq | tee try-modify
> tee: try-modify: Permission denied
$ echo qwq | sudo tee try-modify
$ cat try-modify
> qwq
```


$$\pagebreak$$

## Topic 2: shell tools and shell scripting


