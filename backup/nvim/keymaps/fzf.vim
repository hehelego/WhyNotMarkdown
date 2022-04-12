" find files
nnoremap <silent> <leader>ff :<C-u>Files<CR>
nnoremap <silent> <leader>fg :<C-u>GFiles<CR>
nnoremap <silent> <leader>fh :<C-u>History<CR>
nnoremap <leader>fr :<C-u>Rg 
nnoremap <leader>fa :<C-u>Ag 

" find buffers and windows
nnoremap <silent> <leader>fb :<C-u>Buffers<CR>
nnoremap <silent> <leader>fw :<C-u>Windows<CR>


" find commands
nnoremap <silent> <leader>Fc :<C-u>Commands<CR>
" find registers
nnoremap <silent> <leader>Fr :<C-u>FzfRegister<CR>
" find marks
nnoremap <silent> <leader>Fm :<C-u>Marks<CR>
" find task (asynctasks.vim)
nnoremap <silent> <leader>Ft :<C-u>FzfAsyncTask<CR>
" find help
nnoremap <silent> <leader>Fh :<C-u>Helptags<CR>
