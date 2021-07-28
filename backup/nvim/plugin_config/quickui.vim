"see https://github.com/skywind3000/vim-quickui/blob/master/MANUAL.md 
""
" quickui configuration
""
let g:quickui_color_scheme = 'gruvbox'
let g:quickui_border_style = 2
let g:quickui_show_tip = 1


" TODO: complete the menu
""
" menu
""
call quickui#menu#switch('system')
call quickui#menu#reset()

call quickui#menu#install("FindFiles(&f)", [
			\ [ 'fzf'           , 'Files' ]           ,
			\ [ 'history'       , 'History' ]         ,
			\ [ 'switch buffer' , 'Buffers' ]         ,
			\ [ 'silver-search' , 'Ag' ]              ,
			\ [ 'rip-grep'      , 'Rg' ]              ,
			\ [ '--' ]          ,
			\ [ 'fzf ~'         , 'Files ~' ]         ,
			\ [ 'fzf ~/.config' , 'Files ~/.config' ] ,
			\ [ 'fzf /etc'      , 'Files /etc' ]      ,
			\ [ '--' ]          ,
			\ [ 'term hsplit'   , 'vsplit +terminal'],
			\ [ 'term vsplit'   , 'split +terminal'],
			\ [ 'term newtab'   , 'tabnew +terminal'],
			\])

call quickui#menu#install("CurrentBuffer(&b)" , [
			\ [ 'set filetype' , 'Filetypes' ]      ,
			\ [ '--' ]         ,
			\ [ 'close window' , 'close' ]          ,
			\ [ 'close buffer' , 'bdelete' ]        ,
			\ [ '--' ]         ,
			\ [ 'jump to line' , 'BLines' ]         ,
			\ [ '--' ]         ,
			\ [ 'UndoTree'     , 'UndotreeToggle' ] ,
			\])

call quickui#menu#install("Command(&c)", [
			\ [ 'commands'      , 'Commands' ]      ,
			\ [ 'key-mappings'  , 'Maps' ]          ,
			\ [ 'functions'     , 'function' ]      ,
			\ [ 'cmd-history'   , 'History:' ]      ,
			\ [ '--' ]          ,
			\ [ 'AsyncTastList' , 'AsyncTaskFzf' ]  ,
			\ [ 'AsyncTaskEdit' , 'AsyncTaskEdit' ] ,
			\ [ '--' ]          ,
			\ [ 'show CWD/PWD'  , 'pwd']            ,
			\])

call quickui#menu#install("Editor(&e)", [
			\ [ 'transparent bg' , 'highlight Normal guibg=NONE ctermbg=NONE'] ,
			\ [ 'select theme'   , 'Colors' ]                                  ,
			\ [ '--' ]           ,
			\ [ 'quickfix on'    , 'copen' ]                                   ,
			\ [ 'quickfix off'   , 'cclose' ]                                  ,
			\ [ '--' ]           ,
      \ [ 'number on'      , 'call SetColumnDisplay(1)' ]                ,
      \ [ 'number off'     , 'call SetColumnDisplay(0)' ]                ,
			\ [ '--' ]           ,
      \ [ 'ruler on'       , 'set cursorcolumn' ]                        ,
      \ [ 'ruler off'      , 'set nocursorcolumn' ]                      ,
			\])

call quickui#menu#install("LSP(&l)", [
			\ [ 'vista-ctags' , 'Vista ctags' ] ,
			\ [ 'vista-mdtoc' , 'Vista toc' ]   ,
			\ [ 'vista-coc'   , 'Vista coc' ]   ,
			\ [ '--' ]        ,
			\ [ 'CocAction'   , 'CocAction' ]   ,
			\ [ 'CocCommand'  , 'CocCommand' ]  ,
			\ [ 'CocList'     , 'CocList' ]     ,
			\])
call quickui#menu#install("Git(&g)", [
			\ [ 'fzf git-files'   , 'GFiles' ]        ,
			\ [ 'fzf git-commits' , 'Commits' ]       ,
			\ [ '--' ]            ,
			\ [ 'git status'      , 'Git status']     ,
			\ [ 'git stage-all'   , 'Git add -A' ]    ,
			\ [ 'git stage-this'  , 'Git add %' ]     ,
			\ [ 'git commit'      , 'Git commit' ]    ,
			\ [ 'git push'        , 'Git push' ]      ,
			\ [ 'git pull'        , 'Git pull --ff' ] ,
			\ [ 'git log'         , 'Git log' ]       ,
			\ [ 'git blame'       , 'Git blame' ]     ,
			\])

" TODO:
" MISC menu
call quickui#menu#install("MISC(&p)", [
			\ [ 'cheatsheet'        , 'call KMCS()' ]         ,
			\ [ 'help tags'         , 'Helptags']             ,
			\ [ '--' ]              ,
			\ [ 'markdown preview'  , 'MarkdownPreview' ]     ,
			\ [ 'mdpv stop'         , 'MarkdownPreviewStop' ] ,
			\ [ 'latex preview'     , 'LLPStartPreview' ]     ,
			\ [ '--' ]              ,
      \ [ 'plug.vim install'  , 'PlugInstall' ]         ,
      \ [ 'plug.vim update'   , 'PlugUpdate' ]          ,
      \ [ 'plug.vim clean'    , 'PlugClean' ]           ,
      \ [ 'plug.vim status'   , 'PlugStatus' ]          ,
      \ [ 'plug.vim self-upd' , 'PlugUpgrade' ]         ,
			\ [ '--' ]              ,
			\ [ 'coc.nvim update'   , 'CocUpdate' ]           ,
			\])


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

