"see https://github.com/skywind3000/vim-quickui/blob/master/MANUAL.md


""
" quickui configuration
""
let g:quickui_color_scheme = 'gruvbox'
let g:quickui_border_style = 2


""
" menu
""
call quickui#menu#reset()

call quickui#menu#install("FindFiles(&f)", [
			\ [ 'fzf'           , 'Files']           ,
			\ [ 'history'       , 'History' ]        ,
			\ [ 'swith buffer'  , 'Buffers']         ,
			\ [ 'silver-search' , 'Ag']              ,
			\ [ 'rip-grep'      , 'Rg']              ,
			\ [ '--' ]          ,
			\ [ 'fzf home'      , 'Files ~']         ,
			\ [ 'fzf config'    , 'Files ~/.config'] ,
			\ [ 'fzf etc'       , 'Files /etc']      ,
			\ ])

call quickui#menu#install("CurrentBuffer(&b)" , [
			\ [ 'set filetype'   , 'Filetypes']               ,
			\ [ '--' ]           ,
			\ [ 'jump to line'   , 'BLines']                  ,
			\ [ 'search history' , 'History/' ]               ,
			\ [ '--' ]           ,
			\ [ 'easymotion'     , '<Plug>(easymotion-bd-f)'] ,
			\ ])

call quickui#menu#install("Command(&c)", [
			\ [ 'all-cmd'      , 'Commands' ] ,
			\ [ 'key-mappings' , 'Maps' ]     ,
			\ [ 'history'      , 'History:' ] ,
			\ ])

" TODO:
" git integration
" LSP shortcut menu
" build system shortcut menu
call quickui#menu#install("LSP(&l)", [
			\ [ 'vista-ctags' , 'Vista ctags']  ,
			\ [ 'vista-mdtoc' , 'Vista toc']    ,
			\ [ 'vista-coc'   , 'Vista coc']    ,
			\ [ '--' ]        ,
			\ [ 'CocAction'   , 'CocAction' ]   ,
			\ [ 'CocCommands' , 'CocCommands' ] ,
			\ [ 'CocList'     , 'CocList' ]     ,
			\ ])
call quickui#menu#install("Build(&b)", [
			\ [ 'SECTION:: GNU make'] ,
			\ [ 'make'                , 'AsyncRun make']       ,
			\ [ 'make clean'          , 'AsyncRun make clean'] ,
			\ [ 'make purge'          , 'AsyncRun make purge'] ,
			\ [ '--' ]                ,
			\ [ 'SECTION:: CMake']    ,
			\ [ 'cmake'               , 'AsyncRun cmake']      ,
			\ ])
call quickui#menu#install("Git(&g)", [
			\ [ '--' ] ,
			\ [ '--' ] ,
			\ ])

" TODO:
" MISC menu
call quickui#menu#install("MISC(&p)", [
			\ [ 'all-cmd'         , 'Commands' ]                                  ,
			\ [ 'key-mappings'    , 'Maps' ]                                      ,
			\ [ '--' ]            ,
			\ [ 'history'         , 'History:' ]                                  ,
			\ [ '--' ]            ,
			\ [ 'transparent'     , 'highlight Normal guibg=NONE ctermbg=NONE']   ,
			\ [ 'non transparent' , 'highlight Normal guibg=#282828 ctermbg=235'] ,
			\ ])


""
" key mappings
""
map <silent><leader><space> :call quickui#menu#open()<CR>


