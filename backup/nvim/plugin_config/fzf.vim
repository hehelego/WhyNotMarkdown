" see https://github.com/junegunn/fzf,see https://github.com/BurntSushi/ripgrep,see https://github.com/ggreer/the_silver_searcher
" see https://github.com/junegunn/fzf.vim
" see https://github.com/SpaceVim/SpaceVim/blob/master/autoload/SpaceVim/layers/fzf.vim


" the default setting
"
" let g:fzf_action = {
"       \ 'ctrl-t': 'tab split',
"       \ 'ctrl-h': 'split',
"       \ 'ctrl-x': 'vsplit',
"       \}

let g:fzf_action = {
                  \ 'ctrl-t': 'tab split',
                  \ 'ctrl-v': 'vsplit',
                  \ 'ctrl-h': 'split',
                  \ 'ctrl-s': 'split',
                  \}



" source https://github.com/SpaceVim/SpaceVim/blob/master/autoload/SpaceVim/layers/fzf.vim
command! FzfRegister call s:fzf_regs()
function! s:yank_register(e) abort
      let @" = a:e
      echohl ModeMsg
      echo 'Yanked'
      echohl None
endfunction
function! s:fzf_regs() abort
      function! s:registers_list() abort
            return split(execute('registers'), '\n')[1:]
      endfunction
      call fzf#run(fzf#wrap('registers', {
                        \   'source':  reverse(s:registers_list()),
                        \   'sink':    function('s:yank_register'),
                        \ }))
endfunction

" source https://github.com/SpaceVim/SpaceVim/blob/master/autoload/SpaceVim/layers/fzf.vim
command! FzfFunctions call s:fzf_funcs()
function! s:source_function(e) abort
      execute('verbose function ' . a:e)
endfunction
function! s:fzf_funcs() abort
      function! s:functions_list() abort
            let l:fnlist=split(execute('function'), '\n')[1:]
            let l:ret=[]
            for l:i in l:fnlist
                  let l:j = l:i[len('function'):]
                  let l:j = split(l:j, '(')[0]
                  call insert(l:ret, l:j)
            endfor
            return l:ret
      endfunction
      call fzf#run(fzf#wrap('functions', {
                        \   'source':  reverse(s:functions_list()),
                        \   'sink':    function('s:source_function'),
                        \ }))
endfunction
