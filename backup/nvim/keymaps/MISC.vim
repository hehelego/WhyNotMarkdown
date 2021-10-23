"""""""""""""""""""""""""
"      keymapping       "
"""""""""""""""""""""""""

"""""""""""""""""
" SECITON: MISC
"""""""""""""""""

" prevent lossing visual selection when performing shift s
xnoremap < <gv
xnoremap > >gv

" re-edit, reload current buffer
nnoremap <silent> <leader>r :edit<CR>
xnoremap <silent> <leader>r :edit<CR>

" (temporarily) turn off highlight search result
inoremap <silent><expr> <C-l> execute('nohlsearch')
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR>
xnoremap <silent> <C-l> :<C-u>nohlsearch<CR>

"""""""""""""""""
" SECITON: editor UI
"""""""""""""""""

function! ToggleMouse()
  if matchstr(&mouse,"a")=="a"
    set mouse-=a
  else
    set mouse=a
  endif
endfunction
function! ToggleTransparentBg()
  if !exists("g:transparent_bg_state")
    let g:transparent_bg_state = 0
  endif

  if g:transparent_bg_state==0
    let g:transparent_bg_state = 1
    highlight Normal guibg=NONE ctermbg=NONE
  else
    let g:transparent_bg_state = 0
    execute(":colorscheme " . g:colors_name)
  endif
endfunction
nnoremap <silent> <leader>em :<C-u>call ToggleMouse()<CR>
xnoremap <silent> <leader>em :<C-u>call ToggleMouse()<CR>
nnoremap <silent> <leader>el :<C-u>set cursorline!<CR>
xnoremap <silent> <leader>el :<C-u>set cursorline!<CR>
nnoremap <silent> <leader>ec :<C-u>set cursorcolumn!<CR>
xnoremap <silent> <leader>ec :<C-u>set cursorcolumn!<CR>
nnoremap <silent> <leader>ea :<C-u>set number!<CR>
xnoremap <silent> <leader>ea :<C-u>set number!<CR>
nnoremap <silent> <leader>er :<C-u>set relativenumber!<CR>
xnoremap <silent> <leader>er :<C-u>set relativenumber!<CR>
nnoremap <leader>et :<C-u>call ToggleTransparentBg()<CR>
xnoremap <leader>et :<C-u>call ToggleTransparentBg()<CR>
nnoremap <silent> <leader>es :<C-u>Colors<CR>
xnoremap <silent> <leader>es :<C-u>Colors<CR>


""""""""""""""""""
" SECITON: buffer
""""""""""""""""""

nnoremap <silent> <leader>bt :<C-u>Filetypes<CR>
xnoremap <silent> <leader>bt :<C-u>Filetypes<CR>
nnoremap <silent> <leader>bw :<C-u>write<CR>
xnoremap <silent> <leader>bw :<C-u>write<CR>
nnoremap <silent> <leader>be :edit<CR>
xnoremap <silent> <leader>be :edit<CR>
nnoremap <silent> <leader>bf :BLines<CR>
xnoremap <silent> <leader>bf :BLines<CR>


""""""""""""""""""""""""""""""""""
" SECITON: windows/tabs/buffers
""""""""""""""""""""""""""""""""""

" manipulate window size
nnoremap <silent> <A-Left> :<C-u>vertical resize -3<CR>
xnoremap <silent> <A-Left> :<C-u>vertical resize -3<CR>
nnoremap <silent> <A-Right> :<C-u>vertical resize +3<CR>
xnoremap <silent> <A-Right> :<C-u>vertical resize +3<CR>
nnoremap <silent> <A-Down> :<C-u>resize -3<CR>
xnoremap <silent> <A-Down> :<C-u>resize -3<CR>
nnoremap <silent> <A-Up> :<C-u>resize +3<CR>
xnoremap <silent> <A-Up> :<C-u>resize +3<CR>


" switching between tabs
nnoremap <silent> <A-j> gt
xnoremap <silent> <A-j> gt
nnoremap <silent> <A-k> gT
xnoremap <silent> <A-k> gT
" moving tabs around 
nnoremap <silent> <A-J> :<C-u>tabmove +1<CR>
xnoremap <silent> <A-J> :<C-u>tabmove +1<CR>
nnoremap <silent> <A-K> :<C-u>tabmove -1<CR>
xnoremap <silent> <A-K> :<C-u>tabmove -1<CR>
" delete(close) a buffer
nnoremap <silent> <A-w> :<C-u>bdelete<CR>
xnoremap <silent> <A-w> :<C-u>bdelete<CR>

" quickfix: open/close/jump-to-next-fix/jump-to-previous-fix
nnoremap <silent> <leader>qo :<C-u>copen<CR>
xnoremap <silent> <leader>qo :<C-u>copen<CR>
nnoremap <silent> <leader>qc :<C-u>cclose<CR>
xnoremap <silent> <leader>qc :<C-u>cclose<CR>
nnoremap <silent> <leader>qn :<C-u>cnext<CR>
xnoremap <silent> <leader>qn :<C-u>cnext<CR>
nnoremap <silent> <leader>qp :<C-u>cprevious<CR>
xnoremap <silent> <leader>qp :<C-u>cprevious<CR>

" selected text <-> system clipboard
nnoremap <silent> <leader>xy "+y
xnoremap <silent> <leader>xy "+y
nnoremap <silent> <leader>xp "+p
xnoremap <silent> <leader>xp "+p

"""""""""""""""""
" SECITON: path
"""""""""""""""""

" yank path-of-file to clipboard
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
nnoremap <silent> <leader>pyp :call YankPath(0)<CR>
xnoremap <silent> <leader>pyp :call YankPath(0)<CR>
nnoremap <silent> <leader>pyd :call YankPath(1)<CR>
xnoremap <silent> <leader>pyd :call YankPath(1)<CR>
nnoremap <silent> <leader>pyf :call YankPath(2)<CR>
xnoremap <silent> <leader>pyf :call YankPath(2)<CR>

" insert path of current file
inoremap <silent><expr> <A-f> GetPath(2)
inoremap <silent><expr> <A-F> GetPath(0)


nnoremap <leader>pp :<C-u>cd ..<CR>
xnoremap <leader>pp :<C-u>cd ..<CR>
nnoremap <leader>pw :<C-u>pwd<CR>
xnoremap <leader>pw :<C-u>pwd<CR>
nnoremap <leader>ph :<C-u>cd $HOME<CR>
xnoremap <leader>ph :<C-u>cd $HOME<CR>
