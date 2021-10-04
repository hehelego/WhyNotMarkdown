" see https://github.com/easymotion/vim-easymotion

let maplocalleader='\'
map <LocalLeader> <Plug>(easymotion-prefix)

let g:EasyMotion_smartcase = 1
let g:EasyMotion_do_mapping = 0



" clear highlight-search matches before invoking easymotion, to prevent confusion.

map <Plug>(easymotion-prefix)f <Plug>(easymotion-s)
map <Plug>(easymotion-prefix)F <Plug>(easymotion-s2)

map <Plug>(easymotion-prefix)j <Plug>(easymotion-sol-j)
map <Plug>(easymotion-prefix)k <Plug>(easymotion-sol-k)
map <Plug>(easymotion-prefix)J <Plug>(easymotion-eol-j)
map <Plug>(easymotion-prefix)K <Plug>(easymotion-eol-k)


map <Plug>(easymotion-prefix)w <Plug>(easymotion-bd-w)
map <Plug>(easymotion-prefix)W <Plug>(easymotion-bd-e)
