let maplocalleader=';'

""""""""""""""""""""""""""
" SECTION: global keymaps 
""""""""""""""""""""""""""

" toggle file explorer
nmap <silent> <leader>t :CocCommand explorer<CR>
" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  xnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  xnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif



""""""""""""""""""""""
" SECTION: completion
""""""""""""""""""""""

" when completion popup menu available, use <Tab> and <Shift><Tab> to navigate through candidates
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" : "\<TAB>" 
inoremap <expr><S-TAB>
			\ pumvisible() ? "\<C-p>" : "\<S-TAB>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <Ctrl><Space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

"""""""""""""""""""""""
" SECTION: diagnostics
"""""""""""""""""""""""

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <plug>(coc-diagnostic-prev)
nmap <silent> ]g <plug>(coc-diagnostic-next)




""""""""""""""""""""""""""""
" SECTION: cross references
""""""""""""""""""""""""""""


" GoTo code navigation.
nmap <silent> gd <plug>(coc-definition)
nmap <silent> gy <plug>(coc-type-definition)
nmap <silent> gi <plug>(coc-implementation)
nmap <silent> gr <plug>(coc-references)

" Use K to show documentation in preview window.
nmap <silent> K :call <SID>show_documentation()<CR>
" Use M to show Man pages.
nmap <silent> M :<C-u>Man<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

""""""""""""""""
" SECTION: MISC
""""""""""""""""

" Symbol renaming.
nmap <localleader>r <plug>(coc-rename)

" Formatting selected code.
xmap <silent> <localleader>f <plug>(coc-format-selected)
" Formatting the whole document file
nmap <silent> <localleader>f :<C-u>call CocAction('format')<CR>

" Applying codeAction to the selected region.
xmap <localleader>a  <plug>(coc-codeaction-selected)
" Remap keys for applying codeAction to the current buffer.
nmap <localleader>a  <plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <localleader>q  <plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <plug>(coc-funcobj-i)
omap if <plug>(coc-funcobj-i)
xmap af <plug>(coc-funcobj-a)
omap af <plug>(coc-funcobj-a)
xmap ic <plug>(coc-classobj-i)
omap ic <plug>(coc-classobj-i)
xmap ac <plug>(coc-classobj-a)
omap ac <plug>(coc-classobj-a)

" range selection: <Ctrl>s
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <plug>(coc-range-select)
xmap <silent> <C-s> <plug>(coc-range-select)

""""""""""""""""""""
" SECTION: coc-list
""""""""""""""""""""

nmap <silent> <localleader>lc :<C-u>CocList commands<CR>
nmap <silent> <localleader>ld :<C-u>CocList diagnostics<CR>
nmap <silent> <localleader>lt :<C-u>CocList tasks<CR>
nmap <silent> <localleader>ll :<C-u>CocList<CR>


