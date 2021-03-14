map <C-l> :<C-u>nohlsearch<CR>

noremap <silent> <Left> :<C-u>vertical resize -3<CR>
noremap <silent> <Right> :<C-u>vertical resize +3<CR>
noremap <silent> <Down> :<C-u>resize -3<CR>
noremap <silent> <Up> :<C-u>resize +3<CR>

map <A-j> gT
map <A-k> gt
map <silent> <A-w> :<C-u>bd<CR>
map <silent> <leader>qo :<C-u>copen<CR>
map <silent> <leader>qc :<C-u>cclose<CR>


""""""""""""""""""
" keymapping_cheatsheet
""""""""""""""""""


let s:kmcs_MISC = [
	\ [ '<leader><space>', 'quickui-menu' ],
	\ [ '--' ],
	\ [ '<C-l>', 'nohlsearch' ],
	\ [ '--' ],
	\ [ '<leader>p', 'transparent backgroud'],
	\ [ '<leader>P', 'colorized backgroud'],
	\ [ '--' ],
	\ [ '<left>', 'vsize -3' ],
	\ [ '<right>', 'vsize +3' ],
	\ [ '<up>', 'hsize +3' ],
	\ [ '<down>', 'hsize -3' ],
	\ [ '--' ],
	\ [ '<A-j>', 'next tab' ],
	\ [ '<A-j>', 'previous tab' ],
	\ [ '<A-w>', 'close buffer' ],
	\ [ '<leader>qo', 'quickfix on' ],
	\ [ '<leader>qo', 'quickfix on' ],
  \]
let s:kmcs_builtin = []

let s:kmcs_coc = []
let s:kmcs_fzf = []
let s:kmcs_vista = []
let s:kmcs_asyncrun = []
let s:kmcs_undotree = []
let s:kmcs_rainbow = []
let s:kmcs_tabular = []
let s:kmcs_easymotion = []
let s:kmcs_TEST = [
	\ [ 'a0', 'b0' ],
	\ [ 'a1', 'b1' ],
	\ [ '--' ],
	\ [ 'a2', 'b2' ],
	\ [ 'a3', 'b3' ],
  \]



let g:keymapping_cheatsheet = {
			\ 'MISC'       : s:kmcs_MISC       ,
			\ 'built-in'   : s:kmcs_builtin    ,
			\ 'coc'        : s:kmcs_coc        ,
			\ 'fzf'        : s:kmcs_fzf        ,
			\ 'vista'      : s:kmcs_vista      ,
			\ 'asyncrun'   : s:kmcs_asyncrun   ,
			\ 'undotree'   : s:kmcs_undotree   ,
			\ 'rainbow'    : s:kmcs_rainbow    ,
			\ 'tabular'    : s:kmcs_tabular    ,
			\ 'easymotion' : s:kmcs_easymotion ,
			\ 'TEST'       : s:kmcs_TEST       ,
			\ }

