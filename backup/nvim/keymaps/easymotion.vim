let maplocalleader=','

" [char]
" search for single character
nmap <localleader>f <plug>(easymotion-s)
xmap <localleader>f <plug>(easymotion-s)
" [char,char]
" search for double characters
nmap <localleader>F <plug>(easymotion-s2)
xmap <localleader>F <plug>(easymotion-s2)

" ^line
" goto line head
nmap <localleader>j <plug>(easymotion-sol-bd-jk)
xmap <localleader>j <plug>(easymotion-sol-bd-jk)
nmap <localleader>k <plug>(easymotion-sol-bd-jk)
xmap <localleader>k <plug>(easymotion-sol-bd-jk)
" line$
" goto line end
nmap <localleader>J <plug>(easymotion-eol-bd-jk)
xmap <localleader>J <plug>(easymotion-eol-bd-jk)
nmap <localleader>K <plug>(easymotion-eol-bd-jk)
xmap <localleader>K <plug>(easymotion-eol-bd-jk)

" ^word
" goto word begin
nmap <localleader>w <plug>(easymotion-bd-w)
xmap <localleader>w <plug>(easymotion-bd-w)
" Word$
" goto word end
nmap <localleader>W <plug>(easymotion-bd-e)
xmap <localleader>W <plug>(easymotion-bd-e)



" repeat the last search pattern
nmap <localleader>. <plug>(easymotion-repeat)
xmap <localleader>. <plug>(easymotion-repeat)

" goto next/previous matched pattern
nmap <localleader>n <plug>(easymotion-next)
xmap <localleader>n <plug>(easymotion-next)
nmap <localleader>N <plug>(easymotion-prev)
xmap <localleader>N <plug>(easymotion-prev)
