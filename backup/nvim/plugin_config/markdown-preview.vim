" see https://github.com/iamcco/markdown-preview.nvim


" don't start previewing automatically when entering a markdown buffer
let g:mkdp_auto_start = 0

" don't close the preview windows when switching to another buffer
let g:mkdp_auto_close = 0

" refresh only on buffer saved or leave insert mode instead of real-time previewing
let g:mkdp_refresh_slow = 1

" make the `start-preview` command only available for filetype=markdown
let g:mkdp_command_for_global = 0
" recognized filetypes, these filetypes will have MarkdownPreview... commands
let g:mkdp_filetypes = ['markdown']

" preview server only available to myself
let g:mkdp_open_to_the_world = 0
let g:mkdp_open_ip = ''
" use a custom port to start server or random for empty
let g:mkdp_port = ''
" preview page title,${name} will be replace with the file name
let g:mkdp_page_title = '${name}'

" use firefox to open the preview page
" let g:mkdp_browser = 'firefox'
let g:mkdp_browser = 'qutebrowser'

" print out the preview page url when start preview server
let g:mkdp_echo_preview_url = 1

" options for markdown render
" mkit: markdown-it options for render
" katex: katex options for math
" uml: markdown-it-plantuml options
" maid: mermaid options
" disable_sync_scroll: if disable sync scroll, default 0
" sync_scroll_type: 'middle', 'top' or 'relative', default value is 'middle'
"   middle: mean the cursor position alway show at the middle of the preview page
"   top: mean the vim top viewport alway show at the top of the preview page
"   relative: mean the cursor position alway show at the relative positon of the preview page
" hide_yaml_meta: if hide yaml metadata, default is 1
" sequence_diagrams: js-sequence-diagrams options
" content_editable: if enable content editable for preview page, default: v:false
" disable_filename: if disable filename header for preview page, default: 0
let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1,
    \ 'sequence_diagrams': {},
    \ 'flowchart_diagrams': {},
    \ 'content_editable': v:false,
    \ 'disable_filename': 0
    \ }

" use a custom markdown style must be absolute path
" like '/Users/username/markdown.css' or expand('~/markdown.css')
let g:mkdp_markdown_css = ''

" use a custom highlight style must absolute path
" like '/Users/username/highlight.css' or expand('~/highlight.css')
let g:mkdp_highlight_css = ''


