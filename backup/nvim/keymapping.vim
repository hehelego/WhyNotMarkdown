" turn off highlight for matched patterns (after a search)
map <C-l> :<C-u>nohlsearch<CR>

" manipulate window size
noremap <silent> <Left> :<C-u>vertical resize -3<CR>
noremap <silent> <Right> :<C-u>vertical resize +3<CR>
noremap <silent> <Down> :<C-u>resize -3<CR>
noremap <silent> <Up> :<C-u>resize +3<CR>

" switching between tabs
map <silent> <A-j> gt
map <silent> <A-k> gT
" moving tabs around 
map <silent> <A-J> :<C-u>tabmove +1<CR>
map <silent> <A-K> :<C-u>tabmove -1<CR>
" delete(close) a buffer
map <silent> <A-w> :<C-u>bdelete<CR>

" quickfix: open/close/jump-to-next-fix/jump-to-previous-fix
map <silent> <leader>qo :<C-u>copen<CR>
map <silent> <leader>qc :<C-u>cclose<CR>
map <silent> <leader>qn :<C-u>cnext<CR>
map <silent> <leader>qp :<C-u>cprevious<CR>

" selected text <-> system clipboard
map <silent> <leader>xy "+y
map <silent> <leader>xp "+p

" put path of current file into clipboard
function! GetPath(choice)
  let l:path      = expand('%:p')
  let l:directory = expand('%:p:h')
  let l:file      = expand('%:p:t')
  let l:paths = [l:path, l:directory, l:file]
	return l:paths[a:choice]
endfunction
function! YankPath(choice)
	let l:p = GetPath(a:choice)
  let @+=l:p
  let @"=l:p
endfunction
map <silent> <leader>pyp :call YankPath(0)<CR>
map <silent> <leader>pyd :call YankPath(1)<CR>
map <silent> <leader>pyf :call YankPath(2)<CR>

" insert filename
imap <silent><expr> <A-f> GetPath(2)
imap <silent><expr> <A-F> GetPath(0)


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
			\ [ '<leader>qn'      , 'quickfix next' ],
			\ [ '<leader>qp'      , 'quickfix prev' ],
			\ [ '--' ]       ,
			\ [ '<leader>xc'      , 'xclip copy' ],
			\ [ '<leader>xp'      , 'xclip paste' ],
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
			\ [ '<C-x>'     , 'numerical literals dec' ],
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

