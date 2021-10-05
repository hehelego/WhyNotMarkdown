" see https://github.com/easymotion/vim-easymotion

let maplocalleader='\'
let g:EasyMotion_smartcase = 1
let g:EasyMotion_do_mapping = 0

" clear highlight-search matches before invoking easymotion, to prevent confusion.

nmap <LocalLeader>f <Plug>(easymotion-s)
vmap <LocalLeader>f <Plug>(easymotion-s)
nmap <LocalLeader>F <Plug>(easymotion-s2)
vmap <LocalLeader>F <Plug>(easymotion-s2)

nmap <LocalLeader>j <Plug>(easymotion-sol-j)
vmap <LocalLeader>j <Plug>(easymotion-sol-j)
nmap <LocalLeader>k <Plug>(easymotion-sol-k)
vmap <LocalLeader>k <Plug>(easymotion-sol-k)
nmap <LocalLeader>J <Plug>(easymotion-eol-j)
vmap <LocalLeader>J <Plug>(easymotion-eol-j)
nmap <LocalLeader>K <Plug>(easymotion-eol-k)
vmap <LocalLeader>K <Plug>(easymotion-eol-k)

nmap <LocalLeader>w <Plug>(easymotion-bd-w)
vmap <LocalLeader>w <Plug>(easymotion-bd-w)
nmap <LocalLeader>W <Plug>(easymotion-bd-e)
vmap <LocalLeader>W <Plug>(easymotion-bd-e)
