map <C-l> :<C-u>nohlsearch<CR>

noremap <silent> <Left> :<C-u>vertical resize -3<CR>
noremap <silent> <Right> :<C-u>vertical resize +3<CR>
noremap <silent> <Down> :<C-u>resize -3<CR>
noremap <silent> <Up> :<C-u>resize +3<CR>

map <silent> <A-j> gt
map <silent> <A-k> gT
map <silent> <A-w> :<C-u>bdelete<CR>

map <silent> <leader>qo :<C-u>copen<CR>
map <silent> <leader>qc :<C-u>cclose<CR>
map <silent> <leader>qn :<C-u>cnext<CR>
map <silent> <leader>qp :<C-u>cprevious<CR>

vmap gf :<C-u>call EditSelectedPath()<CR>
vmap gx :<C-u>call XdgopenSelectedPath()<CR>


""""""""""""""""""
" keymapping_cheatsheet
""""""""""""""""""

let s:kmcs_MISC = [
			\ [ '<leader>'        , '<space>' ],
			\ [ '<leader><space>' , 'quickui-menu' ],
			\ [ '--' ]            ,
			\ [ '<left>'          , 'vsize -3' ],
			\ [ '<right>'         , 'vsize +3' ],
			\ [ '<up>'            , 'hsize +3' ],
			\ [ '<down>'          , 'hsize -3' ],
			\ [ '--' ]            ,
			\ [ '<A-j>'           , 'next tab' ],
			\ [ '<A-j>'           , 'previous tab' ],
			\ [ '<A-w>'           , 'close buffer' ],
			\ [ '--' ]            ,
			\ [ '<C-l>'           , 'nohlsearch' ],
			\ [ '--' ]            ,
			\ [ '<leader>qo'      , 'quickfix on' ],
			\ [ '<leader>qc'      , 'quickfix off' ],
			\ [ '--' ]       ,
			\ [ '<C-f>'      , 'popup/float scroll down' ],
			\ [ '<C-b>'      , 'popup/floag scroll up' ],
			\]
let s:kmcs_builtin = [
			\ [ '# / *'     , 'match the word under cursor forward/backward' ],
			\ [ '^ / $'     , 'jump to begin/end of current line' ],
			\ [ '%'         , 'jump to matched brace/bracket' ],
			\ [ '--' ]      ,
			\ [ '<C-w>c'    , 'close window' ],
			\ [ '<C-w>s'    , 'vertical split' ],
			\ [ '<C-w>h'    , 'horizontal split' ],
			\ [ '<C-w>hjkl' , 'focus another windows' ],
			\ [ '<C-w>HJKL' , 'move the focused window' ],
			\ [ '<C-w>='    , 'equalize size' ],
			\ [ '--' ]      ,
			\ [ '<C-a>'     , 'numerical literals inc' ],
			\ [ '<C-a>'     , 'numerical literals dec' ],
			\ [ '--' ]      ,
			\ [ '<C-u>'     , 'scroll up' ],
			\ [ '<C-d>'     , 'scroll down' ],
			\ [ '<C-b>'     , 'page up' ],
			\ [ '<C-f>'     , 'page down' ],
			\ [ '--' ]      ,
			\ [ 'gf'        , 'edit <cword>' ],
			\ [ 'gx'        , 'xdg-open <cword>' ],
			\ [ '--' ]      ,
			\]




let s:kmcs_coc = [
	\ [ '<C-Space>'  , 'autocomplete refresh' ],
	\ [ '<S-k>/K'    , 'popup documentation' ],
	\ [ '--' ]       ,
	\ [ '[g'         , 'jump to previous diagnostic' ],
	\ [ ']g'         , 'jump to next diagnostic' ],
	\ [ '--' ]       ,
	\ [ 'gd'         , 'goto definition' ],
	\ [ 'gy'         , 'goto type-definition' ],
	\ [ 'gi'         , 'goto implementation' ],
	\ [ 'gr'         , 'goto refrences' ],
	\ [ '--' ]       ,
	\ [ '<Leader>rn' , 'rename the variable under cursor' ],
	\ [ '<Leader>f'  , 'format selected code' ],
	\ [ '--' ]       ,
	\ [ '<C-s>'      , 'range selection' ],
  \]
let s:kmcs_fzf = [
			\ [ '<Tab>' , 'toggle select' ],
			\ [ '<C-n>' , 'move next' ],
			\ [ '<C-p>' , 'move previous' ],
			\ [ '--' ]  ,
			\ [ '<C-t>' , 'open in new tab' ],
			\ [ '<C-v>' , 'open in V-split' ],
			\ [ '<C-h>' , 'open in H-split' ],
			\]
let s:kmcs_vista = []
let s:kmcs_asyncrun = []
let s:kmcs_undotree = []
let s:kmcs_rainbow = []
let s:kmcs_tabular = []
let s:kmcs_nerdcomment = [
	\ [ '<leader>cc' , 'add comment current line/selected text' ],
	\ [ '<leader>cu' , 'uncomment   current line/selected text' ],
  \]
let s:kmcs_easymotion = [
			\ [ '\'     , 'easymotion-mapleader' ],
			\ [ '--' ]  ,
			\ [ 'f[x]'  , 'find a single character [x]' ],
			\ [ 'F[xy]' , 'find two characters [xy]' ],
			\ [ 'w/W'   , 'find ^(word)/(word)$' ],
			\ [ 'j/k'   , 'find ^(line) forward/backward' ],
			\ [ 'J/K'   , 'find (line)$ forward/backward' ],
			\]


let g:keymapping_cheatsheet = {
			\ 'MISC'           : s:kmcs_MISC        ,
			\ 'built-in'       : s:kmcs_builtin     ,
			\ 'coc'            : s:kmcs_coc         ,
			\ 'fzf'            : s:kmcs_fzf         ,
			\ 'vista'          : s:kmcs_vista       ,
			\ 'asyncrun'       : s:kmcs_asyncrun    ,
			\ 'undotree'       : s:kmcs_undotree    ,
			\ 'rainbow'        : s:kmcs_rainbow     ,
			\ 'tabular'        : s:kmcs_tabular     ,
			\ 'nerd-commenter' : s:kmcs_nerdcomment ,
			\ 'easymotion'     : s:kmcs_easymotion  ,
			\ }

