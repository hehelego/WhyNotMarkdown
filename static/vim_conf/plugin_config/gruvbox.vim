" see https://github.com/morhetz/gruvbox

let g:gruvbox_bold=1
let g:gruvbox_italic=1
let g:gruvbox_transparent_bg=1
let g:gruvbox_underline=1
let g:gruvbox_undercurl=1
let g:gruvbox_termcolors=256

colorscheme gruvbox

highlight Normal ctermbg=NONE guibg=None

map <space>p :highlight Normal guibg=NONE ctermbg=NONE<CR>
map <space>P :highlight Normal guibg=#282828 ctermbg=235<CR>
