" see https://github.com/liuchengxu/vista.vim

" shortcuts in VistaBuffer
" <CR>  - jump to the tag under the cursor.
" p     - preview the tag under the context via the floating window if it's avaliable.
" s     - sort the symbol alphabetically or the location they are declared.
" q     - close the vista window.

let g:vista_default_executive = 'ctags'

let g:vista_fzf_preview = ['right:50%']

let g:vista_sidebar_position = 'vertical topleft'

let g:vista#renderer#enable_icon = 1

let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
let g:vista#renderer#icons = {
\   "function": "\uf794",
\   "variable": "\uf71b",
\  }


let g:vista_lsp_client = 'coc'
