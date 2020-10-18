# using LaTeX

## reference/resources

> - [lshort: A short introduction to LaTeX](https://www.ctan.org/tex-archive/info/lshort/),也可以用`texdoc lshort`来获取.(中文翻译叫`lshort-zh-cn`)
> - google/bing/baidu
> - stack overflow/zhihu/quaro




## LaTeX FAQ

<<<<<<< HEAD:record-and-tricks/note-on-latex.md
- 推荐使用texlive这个tex发行版,推荐使用texlive.iso进行安装,而不是软件包管理器,安装参考lshort,lshort-zh-cn.配置tex工作环境还是有些麻烦的.
- 寻找texlive-fontconfig.conf困难?使用fzf在根目录搜索吧
=======
- 推荐使用texlive这个tex发行版(please use the `texlive.iso` to install TeXlive instead of using pacman),安装参考lshort,lshort-zh-cn.配置tex工作环境还是有些麻烦的.
- can't find `texlive-fontconfig.conf`, try `fzf`
>>>>>>> refs/remotes/origin/master:record-and-tricks/note-on-latexr.md
- 使用了中文,为什么编译挂了? 因为需要`xelatex`.
- 如何换行:直接使用`\\`是无法换行的,需要一个aligned环境才可以用(在aligned环境中需要注意使用`&`来标识对齐位置以及对齐起点),当然,你也可以用equation环境(默认居中对齐,不允许自定义对齐),如果不想要equation环境的自动编号,则用`\begin{equation*} \end{equation*}`代替.
- 如何使用多行下标:使用`\begin{subarray}{l/r/c} \end{subarray}`创建多行下标的环境,参数标识左/右对齐或者居中(在这个环境中,不可以使用`&`来自定义对齐规则).
- 为啥我用`p \and q`不行啊? 现在用的是`\land`不少参考资料已经过时了,建议查较近时间段的文档.
- 关于不等号`\gt \lt`,它们已经被废弃了,现在可以直接用`> <`输入了,其他不等式关系符号基本上没有调整.
- 为啥我空了一行就行了/不行了? 建议学习latex语法...不要乱用空格和反斜线,以及换行(大概就是:使用`\\`必须在一个允许它的环境;不能直接空行;连续`\\`不会打出空行,要使用`\newline`命令).
- 使用`\pagebreak,\newpage`命令来换页,不让页面过于臃肿.
- mathjax的渲染效果和pdflatex,xelatex是有很大不同的...对语法的严格程度也有天壤之别.
- 编译为pdf的时候可能有`[WARNING] missing font for unicode character XXX`可以试试换其他代替符号,比如`\setminus <-> \backslash`当然这并不靠谱.**本人目前没有找到解决方案**

