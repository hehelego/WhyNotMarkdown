" stop the running task
nnoremap <silent> <leader>as :<C-u>AsyncStop<CR>

" repate the last task
nnoremap <silent> <leader>a. :<C-u>AsyncTaskLast<CR>

" list all the available tasks
nnoremap <silent> <leader>aa :<C-u>FzfAsyncTask<CR>
