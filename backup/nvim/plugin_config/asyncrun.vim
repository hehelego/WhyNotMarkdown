" see https://github.com/skywind3000/asyncrun.vim
" see https://github.com/skywind3000/asynctasks.vim

let g:terminal_kill = 1

let g:asyncrun_open = 6

let g:asyncrun_exit = "silent call system('notify-send -u low -t 1000 [vim: AsyncRun] finished')"

  let g:asynctasks_extra_config = [
      \ '~/.config/nvim/common_tasks.ini'
      \ ]


function! s:fzf_sink(what)
	let p1 = stridx(a:what, '<')
	if p1 >= 0
		let name = strpart(a:what, 0, p1)
		let name = substitute(name, '^\s*\(.\{-}\)\s*$', '\1', '')
		if name != ''
			exec "AsyncTask ". fnameescape(name)
		endif
	endif
endfunction

function! s:fzf_task()
	let rows = asynctasks#source(&columns * 48 / 100)
	let source = []
	for row in rows
		let name = row[0]
		let source += [name . '  ' . row[1] . '  : ' . row[2]]
	endfor
	let opts = {
				\ 'source': source, 'sink': function('s:fzf_sink'),
				\ 'options': '+m --nth 1 --inline-info' }
	if exists('g:fzf_layout')
		for key in keys(g:fzf_layout)
			let opts[key] = deepcopy(g:fzf_layout[key])
		endfor
	endif
	call fzf#run(fzf#wrap(opts))
endfunction


command! -nargs=0 FzfAsyncTask call s:fzf_task()
