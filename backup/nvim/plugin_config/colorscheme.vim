let s:cs='onedark'

" see https://github.com/morhetz/gruvbox
if s:cs=='gruvbox'
  let g:gruvbox_bold=1
  let g:gruvbox_italic=1
  let g:gruvbox_transparent_bg=1
  let g:gruvbox_underline=1
  let g:gruvbox_undercurl=1
  let g:gruvbox_termcolors=256


  let g:airline_theme='gruvbox'
  colorscheme gruvbox
  autocmd vimenter * ++nested colorscheme gruvbox
endif


" see https://github.com/joshdick/onedark.vim
if s:cs=='onedark'
  let g:onedark_termcolors=256
  let g:onedark_terminal_italics=1
  let g:onedark_hide_endofbuffer=1

  let g:airline_theme='onedark'
  colorscheme onedark
  autocmd vimenter * ++nested colorscheme onedark
endif
