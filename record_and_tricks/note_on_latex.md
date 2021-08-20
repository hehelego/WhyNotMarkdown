# using LaTeX

## reference/resources

> - [lshort: A short introduction to LaTeX](https://www.ctan.org/tex-archive/info/lshort/),`PDEVIEWER=okular texdoc lshort` to open the document.(or `lshort-zh-cn` for a chinese translated version)
> - use the search engine
> - take advantage of [TeX stack exchange](https://tex.stackexchange.com/),`zhihu`,`latex forum`,`github`

## LaTeX basis

## LaTeX tips

### general tips

- my workflow
  - LaTeX distribution: TeXLive(推荐使用ISO安装, 安装)
  - editing and previewing: vim+latex-live-preivew
  - compiler: xelatex
  - CJK support: xeCJK(非侵入式,调整配置简单).

- 使用TeXLive ISO安装之后,记得参考`lshort-zh-cn`做一些字体相关配置.
- 忘记了`texlive/texmf-dist`在哪里,使用`rg / --files | rg texlive | fzf`进行查找.
- 先读`lshort`再提问,先看`texdoc`再提问.
- 注意解决方案的时效性.

### breaking changes / deprecated commands

- logic operators in math mode: `\land,\lor,\lnot`, instead of `\and \or \not`.
- inequalities : no more `\gt,\lt`, simply `>,<`

