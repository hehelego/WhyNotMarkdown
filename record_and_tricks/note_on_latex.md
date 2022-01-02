# using LaTeX

- my workflow
  - distribution: TeXLive
  - PDF viewer: okular and pdf.js
  - editor: (neo)vim with TexLab LSP server and coc.nvim LSP client
  - compiler: latexmk, pdflatex/xelatex
  - CJK support: xeCJK
- 使用TeXLive ISO安装之后, 记得参考`lshort-zh-cn`做一些字体相关配置.
- 在arch linux环境下, 有 AUR `texlive-installer` 为上游提供的安装器
- 忘记了`texlive/texmf-dist`在哪里, 使用`rg / --files | rg texlive | fzf`进行查找.
- 遇到问题, 在提问求助之前, 记得利用搜索引擎尝试获取信息并且阅读相关文档.
- **注意解决方案的时效性**

## reference/resources

- [lshort: A short introduction to LaTeX](https://www.ctan.org/tex-archive/info/lshort/),`PDEVIEWER=okular texdoc lshort` to open the document.(or `lshort-zh-cn` for a chinese translated version)
- [TeX stack exchange](https://tex.stackexchange.com/),`zhihu`,`latex forum`,`github`
- [arch wiki: TeX Live](https://wiki.archlinux.org/title/TeX_Live)
- [overleaf](https://www.overleaf.com/learn)
- use the search engine (STFW)

## LaTeX basis

## LaTeX tips

### latexmk fish shell script

```fish
#!/usr/bin/fish
if not test -d tex-output
  mkdir tex-output
end

latexmk \
  -output-directory=tex-output \
  -shell-escape \
  -pdf \
  -pdflatex=xelatex \
  document.tex
```

### [put text at the bottom of the page](https://tex.stackexchange.com/questions/245247/putting-text-at-the-bottom-of-the-page)

```latex
Some random text in the page
\vspace*{\fill}
Text that will now be at the bottom of the page
```

### minted: remember to specify the output directory

```latex
\usepackage[outputdir=tex-output, cachedir=tex-output]{minted}
```

### breaking changes / deprecated commands

- logic operators in math mode: `\land,\lor,\lnot`, instead of `\and \or \not`.
- inequalities : no more `\gt,\lt`, simply `>,<`
