" see https://github.com/xuhdev/vim-latex-live-preview

" use okular to open the preview PDF file
let g:livepreview_previewer = 'okular'

" specify the default latex engine
let g:livepreview_engine = 'xelatex'



" re-compile only on buffer save,
" don't re-compile it on CursorHold
let g:livepreview_cursorhold_recompile = 0
