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

" source vimscript in current buffer
nnoremap <silent> <leader>s :source %<CR>
xnoremap <silent> <leader>s :source %<CR>

" (temporarily) turn off highlight search result: <Ctrl>+l
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


"""""""""""""""""
" SECITON: path
"""""""""""""""""

" insert path of current file
inoremap <silent><expr> <A-f> expand('%')

"""""""""""""""""
" SECITON: clipboard
"""""""""""""""""

" selected text <-> X11 xclip clipboard/primary
nnoremap <silent> <leader>yx "+y
xnoremap <silent> <leader>yx "+y
nnoremap <silent> <leader>px "+p
xnoremap <silent> <leader>px "+p
nnoremap <silent> <leader>yX "*y
xnoremap <silent> <leader>yX "*y
nnoremap <silent> <leader>pX "*p
xnoremap <silent> <leader>pX "*p

"""""""""""""""""
" SECITON: words look up
"""""""""""""""""

" lookup the word using [ydcv](https://github.com/farseerfc/ydcv-rs)
function! LookupWord(word)
python3 << ENDPY
try:
  def lookup(word):
    import subprocess
    subprocess.run(['ydcv', '-n', word], timeout=1)

  import vim
  lookup(vim.eval('a:word'))
except Exception as e:
  print(f'[error: LookupWord] {e}')
ENDPY
endfunction

nnoremap <silent><expr> <leader>w LookupWord(expand('<cword>'))
