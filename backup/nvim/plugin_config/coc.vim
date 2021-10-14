" see https://github.com/neoclide/coc.nvim

" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.


" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')


" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

"" coc extensions
let g:coc_global_extensions = [
  \ 'coc-clangd',
  \ 'coc-cmake',
  \ 'coc-explorer',
  \ 'coc-fish',
  \ 'coc-format-json',
  \ 'coc-go',
  \ 'coc-html',
  \ 'coc-json',
  \ 'coc-lua',
  \ 'coc-markdownlint',
  \ 'coc-marketplace',
  \ 'coc-pyright',
  \ 'coc-rust-analyzer',
  \ 'coc-tasks',
  \ 'coc-texlab',
  \ 'coc-toml',
  \ 'coc-vimlsp',
  \ 'coc-yaml',
  \ ]
