# load the autoconfig file: $HOME/.config/qutebrowser/autoconfig.yml
config.load_autoconfig()

# enable HiDPI support
config.set('qt.highdpi', True)

# enable GPU acceleration
# see [https://github.com/qutebrowser/qutebrowser/discussions/6573, https://github.com/qutebrowser/qutebrowser/issues/5378]
config.set('qt.args',['ignore-gpu-blacklist','enable-gpu-rasterization','enable-native-gpu-memory-buffers','num-raster-threads=4','enable-accelerated-video-decode'])

# use socks5 proxy
config.set('content.proxy', 'socks://127.0.0.1:1089')

# use socks5 proxy
config.set('content.autoplay', False)

# allow viewing pdf using pdfjs
config.set('content.pdfjs', True)

# render the page in dark theme if possible
config.set('colors.webpage.preferred_color_scheme','dark')

# fonts
config.set('fonts.default_family','sans-serif')

# external editor command
#  config.set('editor.command', ["codium", "--goto", "{file}:{line}:{column0}"])
config.set('editor.command', ["alacritty", "-e", "nvim", "-c", "normal {line}G{column0}|", "--", "{file}"])

# externel file selector command
config.set('fileselect.folder.command', ["alacritty", "-e", "ranger", "--choosedir={}"])
config.set('fileselect.single_file.command', ["alacritty", "-e", "ranger", "--choosefile={}"])
config.set('fileselect.multiple_files.command', ["alacritty", "-e", "ranger", "--choosefiles={}"])

# set smooth scrolling
config.set('scrolling.smooth', True)

# key bindings for tab-manipulation
config.bind('<Alt-j>','tab-next', mode='normal')
config.bind('<Alt-k>','tab-prev', mode='normal')
config.bind('<Alt-Shift-k>','tab-move -', mode='normal')
config.bind('<Alt-Shift-j>','tab-move +', mode='normal')
config.bind('<Alt-w>','tab-close', mode='normal')
config.bind('<Alt-p>','tab-pin', mode='normal')
config.bind('<Alt-m>','tab-mute', mode='normal')

# key binding for edit url
config.bind('<Space>eu','edit-url', mode='normal')

# keepassxc integration
config.bind('<Alt-p>', 'spawn --userscript qute-keepassxc --key qutebrowser-keepassxc-connection-233', mode='insert')
config.bind('<Space>pw', 'spawn --userscript qute-keepassxc --key qutebrowser-keepassxc-connection-233', mode='normal')

# keybindgs for reload config.py
config.bind('<Space>c', 'config-source', mode='normal')
config.bind('<Space>r', 'config-source', mode='normal')

# keybindgs to run the userscript for testing
config.bind('<Space>tt', 'spawn --userscript test.py', mode='normal')

# spinach bookmarks key bindings
config.bind('<Space>boo', 'spawn --userscript spinach-bookmarks.py', mode='normal')
config.bind('<Space>boa', 'spawn --userscript spinach-bookmarks.py --tags-match-any', mode='normal')
config.bind('<Space>boe', 'spawn --userscript spinach-bookmarks.py --tags-match-every', mode='normal')
config.bind('<Space>btt', 'spawn --userscript spinach-bookmarks.py --tab', mode='normal')
config.bind('<Space>bta', 'spawn --userscript spinach-bookmarks.py --tab --tags-match-any', mode='normal')
config.bind('<Space>bte', 'spawn --userscript spinach-bookmarks.py --tab --tags-match-every', mode='normal')
config.bind('<Space>bww', 'spawn --userscript spinach-bookmarks.py --window', mode='normal')
config.bind('<Space>bwa', 'spawn --userscript spinach-bookmarks.py --window --tags-match-any', mode='normal')
config.bind('<Space>bwe', 'spawn --userscript spinach-bookmarks.py --window --tags-match-every', mode='normal')
