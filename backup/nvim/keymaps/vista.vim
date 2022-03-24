nnoremap <silent> <leader>vv :<C-u>Vista!!<CR>
nnoremap <silent> <leader>vo :<C-u>Vista focus<CR>
nnoremap <silent> <leader>vc :<C-u>Vista!<CR>

nnoremap <silent> <leader>vf :<C-u>Vista finder<CR>
nnoremap <silent> <leader>vF :<C-u>Vista finder!<CR>

nnoremap <silent> <leader>vt :<C-u>Vista ctags<CR>
if g:vista_lsp_client == 'coc'
  nnoremap <silent> <leader>vl :<C-u>Vista coc<CR>
endif

nnoremap <silent> <leader>vm :<C-u>Vista toc<CR>
