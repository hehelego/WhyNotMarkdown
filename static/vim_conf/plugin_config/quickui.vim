"see https://github.com/skywind3000/vim-quickui/blob/master/MANUAL.md 
""
" quickui configuration
""
let g:quickui_color_scheme = 'gruvbox'
let g:quickui_border_style = 2
let g:quickui_show_tip = 1


""
" menu
""
call quickui#menu#switch('system')
call quickui#menu#reset()

call quickui#menu#install("FindFiles(&f)", [
			\ [ 'fzf'           , 'Files'],
			\ [ 'history'       , 'History' ],
			\ [ 'switch buffer' , 'Buffers'],
			\ [ 'switch window' , 'Windows'],
			\ [ 'silver-search' , 'Ag'],
			\ [ 'rip-grep'      , 'Rg'],
			\ [ '--' ]          ,
			\ [ 'fzf home'      , 'Files ~'],
			\ [ 'fzf config'    , 'Files ~/.config'],
			\ [ 'fzf etc'       , 'Files /etc'],
			\ ])

call quickui#menu#install("CurrentBuffer(&b)" , [
			\ [ 'set filetype'   , 'Filetypes'],
			\ [ '--' ]           ,
			\ [ 'close window'   , 'close'],
			\ [ 'close buffer'   , 'bdelete'],
			\ [ '--' ]           ,
			\ [ 'jump to line'   , 'BLines'],
			\ [ 'search history' , 'History/' ],
			\ ])

call quickui#menu#install("Command(&c)", [
			\ [ 'all-cmd'      , 'Commands' ],
			\ [ 'key-mappings' , 'Maps' ],
			\ [ 'history'      , 'History:' ],
			\ ])

call quickui#menu#install("Editor(&e)", [
			\ [ 'undo-tree'       , 'UndotreeToggle' ],
			\ [ '--' ]            ,
			\ [ 'quickfix on'     , 'copen'],
			\ [ 'quickfix off'    , 'cclose'],
			\ [ '--' ]            ,
			\ [ 'transparent'     , 'highlight Normal guibg=NONE ctermbg=NONE'],
			\ [ 'non transparent' , 'highlight Normal guibg=#282828 ctermbg=235'],
			\ [ '--' ]            ,
      \ [ 'ruler on'        , 'set cursorcolumn' ],
      \ [ 'ruler off'       , 'set nocursorcolumn' ],
			\ [ '--' ]            ,
      \ [ 'number on'       , 'call SetColumnDisplay(1)' ],
      \ [ 'number off'      , 'call SetColumnDisplay(0)' ],
			\ ])

" TODO:
" git integration
" LSP shortcut menu
" build system shortcut menu
call quickui#menu#install("LSP(&l)", [
			\ [ 'vista-ctags' , 'Vista ctags'],
			\ [ 'vista-mdtoc' , 'Vista toc'],
			\ [ 'vista-coc'   , 'Vista coc'],
			\ [ '--' ]        ,
			\ [ 'CocAction'   , 'CocAction' ],
			\ [ 'CocCommand'  , 'CocCommand' ],
			\ [ 'CocList'     , 'CocList' ],
			\ ])
call quickui#menu#install("Build(&s)", [
			\ [ 'SECTION:: GNU make'] ,
			\ [ 'make'                , 'AsyncRun make'],
			\ [ 'make clean'          , 'AsyncRun make clean'],
			\ [ 'make purge'          , 'AsyncRun make purge'],
			\ [ '--' ]                ,
			\ [ 'SECTION:: CMake']    ,
			\ [ 'cmake'               , 'AsyncRun cmake'],
			\ ])
call quickui#menu#install("Git(&g)", [
			\ [ '--' ] ,
			\ [ '--' ] ,
			\ ])

" TODO:
" MISC menu
call quickui#menu#install("MISC(&p)", [
			\ [ 'cheatsheet'       , 'call KMCS()'],
			\ [ '--' ]             ,
			\ [ 'markdown preview' , 'MarkdownPreview'],
			\ [ 'latex preview'    , 'LLPStartPreview'],
			\ [ '--' ]             ,
      \ [ 'plug.vim status'    , 'PlugStatus' ],
      \ [ 'plug.vim update'    , 'PlugUpdate' ],
      \ [ 'plug.vim clean'     , 'PlugClean' ],
      \ [ 'plug.vim self-upd'  , 'PlugUpgrade' ],
			\ ])


""
" key mappings
""
nnoremap <silent><leader><space> :call quickui#menu#open('system')<CR>


""
" keymappings cheatsheet
""
function g:KMCS()
	call s:KMCS_get()
	let l:opts = {'index':g:quickui#listbox#cursor, 'title': 'cheatsheet'}
	call quickui#listbox#open(s:kmcs, l:opts)
endfunction

function g:KMCS_once(name)
	let l:raw_content  = deepcopy(g:keymapping_cheatsheet[a:name])
	let l:content = map(l:raw_content,
				\ {i,v ->
				\   len(v)<2?"\n":
				\     printf("%s\t%s",v[0],v[1])
				\ }
				\)
	let l:opts = {'index':g:quickui#listbox#cursor, 'title': printf('[%s]',a:name)}
	if len(l:content)==0
		let l:content = [
					\ '##NOTHING##',
					\ '##empty cheatsheet##',
					\ '##NOTHING##',
					\]
	endif
	call quickui#listbox#open(l:content, l:opts)
endfunction

function s:KMCS_get()
	if !exists('g:KMCS_initflag')
		let s:kmcs = []
		let g:KMCS_initflag = 1

		for l:key in keys(g:keymapping_cheatsheet)
			call add(s:kmcs,[
						\ l:key,
						\ printf('call g:KMCS_once("%s")',l:key)
						\])
		endfor
	endif
	return s:kmcs
endfunction


""
" set number on/off
""
function g:SetColumnDisplay(s)
  if a:s
    let &number=1
    let &relativenumber=1
    let &signcolumn="auto"
  else
    let &number=0
    let &relativenumber=0
    let &signcolumn="no"
  endif
endfunction

