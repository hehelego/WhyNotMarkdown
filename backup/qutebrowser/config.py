# pylint: disable=C0111
from qutebrowser.config.configfiles import ConfigAPI  # noqa: F401
config: ConfigAPI = config  # noqa: F821 pylint: disable=E0602,C0103

##################################### PART A: configurations #####################################

# load the autoconfig file: $HOME/.config/qutebrowser/autoconfig.yml
config.load_autoconfig()

config.set('bindings.key_mappings', dict())
config.set('colors.webpage.preferred_color_scheme', 'dark')
config.set('content.autoplay', False)
config.set('content.javascript.can_access_clipboard', True)
config.set('content.pdfjs', True)
config.set('content.proxy', 'http://127.0.0.1:8889')
config.set('fonts.default_family', 'monospace')
config.set('scrolling.smooth', True)
config.set('qt.highdpi', True)

# enable GPU acceleration
# see https://github.com/qutebrowser/qutebrowser/discussions/6573
# see https://github.com/qutebrowser/qutebrowser/issues/5378]
config.set('qt.args', [
    'ignore-gpu-blocklist',
    'enable-gpu-rasterization',
    'enable-native-gpu-memory-buffers',
    'num-raster-threads=4',
    'enable-accelerated-video-decode'])

# command for external editor
# see https://github.com/qutebrowser/qutebrowser/issues/5340
#  config.set('editor.command', ['codium', '--goto', '{file}:{line}:{column0}'])
#  config.set('editor.command', ['alacritty', '-e', 'nvim', '-c', 'normal {line}G{column0}l', '--', '{file}'])
#  config.set('editor.command', ['kate', '--startanon', '--line', '{line}', '--column', '{column}', '{file}'])
#  config.set('editor.command', ['gedit','--new-window', '{file}','+{line}:{column}'])
config.set('editor.command', ["nvim-qt", "--nofork",
           "{file}", "--", "-c", "normal {line}G{column0}l"])


# use default rather than external file selector for HTML file upload form.
config.set('fileselect.handler', 'external')
# command for external file selector
config.set('fileselect.folder.command', [
           'alacritty', '-e', 'ranger', '--choosedir={}'])
config.set('fileselect.single_file.command', [
           'alacritty', '-e', 'ranger', '--choosefile={}'])
config.set('fileselect.multiple_files.command', [
           'alacritty', '-e', 'ranger', '--choosefiles={}'])


##################################### PART B: key bindings #####################################

# remove the default key bindings: forward | back | tab-next | tab-prev | tab-pin | tab-move | tab-move - | tab-move + | tab-only | tab-give | tab-clone | tab-take
config.unbind('H', mode='normal')
config.unbind('J', mode='normal')
config.unbind('K', mode='normal')
config.unbind('L', mode='normal')
config.unbind('<Ctrl-p>', mode='normal')
config.unbind('gm', mode='normal')
config.unbind('gK', mode='normal')
config.unbind('gJ', mode='normal')
config.unbind('co', mode='normal')
config.unbind('gD', mode='normal')
config.unbind('gC', mode='normal')
config.unbind('gt', mode='normal')
# remove the default key bindings: bookmark-add | quickmark-add | bookmark-load
config.unbind('M', mode='normal')
config.unbind('m', mode='normal')
config.unbind('gb', mode='normal')
# remove the default key bindings: download | download-cancel | download-clear
config.unbind('gd', mode='normal')
config.unbind('ad', mode='normal')
config.unbind('cd', mode='normal')
# remove the default key bindings: bookmark-add,quickmark-add,bookmark-load
config.unbind('<Ctrl-e>', mode='insert')


# tab-manipulation
config.bind('gt', 'tab-next', mode='normal')
config.bind('gT', 'tab-prev', mode='normal')
config.bind('<Alt-j>', 'tab-next', mode='normal')
config.bind('<Alt-k>', 'tab-prev', mode='normal')
config.bind('<Alt-Shift-k>', 'tab-move -', mode='normal')
config.bind('<Alt-Shift-j>', 'tab-move +', mode='normal')
config.bind('<Alt-w>', 'tab-close', mode='normal')
config.bind('<Alt-p>', 'tab-pin', mode='normal')
config.bind('<Alt-m>', 'tab-mute', mode='normal')

# navigating through history
config.bind('<Alt-h>', 'back', mode='normal')
config.bind('<Alt-l>', 'forward', mode='normal')

# open developer tool
config.bind('<Space>td', 'devtools', mode='normal')
config.bind('<F12>', 'devtools', mode='normal')
config.bind('<F12>', 'devtools', mode='insert')

# print page
config.bind('<Ctrl-Alt-p>', 'print', mode='normal')
config.bind('<Ctrl-Shift-p>', 'print', mode='normal')

# toggle proxy
config.bind(
    '<Space>tp', 'config-cycle -tp content.proxy http://127.0.0.1:8889 socks5://127.0.0.1:1089 none')

# edit url in external editor
config.bind('<Space>eu', 'edit-url', mode='normal')
# edit command in external editor
config.bind('<Space>ec', 'edit-command', mode='normal')
# edit text-field in external editor
config.bind('<Alt-e>', 'edit-text', mode='insert')

# play video in MPV
config.bind('<Space>m', 'hint links spawn mpv {hint-url}', mode='normal')


# keepassxc integration
config.bind('<Alt-u>', 'spawn --userscript qute-keepassxc --key qutebrowser-keepassxc-connection-233', mode='insert')
config.bind('<Space>pw', 'spawn --userscript qute-keepassxc --key qutebrowser-keepassxc-connection-233', mode='normal')

# reload config.py
config.bind('<Space>C', 'config-source', mode='normal')
# restart qutebrowser
config.bind('<Space>R', 'restart', mode='normal')

# ZEN mode (hidding the tab-bar and status-bar)
config.bind('<Space>z', 'config-cycle -tp statusbar.show never always ;; config-cycle -tp tabs.show never always ;; clear-messages ;; download-clear')


##################################### PART C: userscripts #####################################

# run the developing userscript
config.bind('<Space>T', 'spawn --userscript test.py', mode='normal')

# spinach's bookmarks selector: open bookmark, with full feature
config.bind('<Space>b', 'spawn --userscript spinach-bookmarks.py --full', mode='normal')
# override the default key bindings
config.bind('b', 'spawn --userscript spinach-bookmarks.py', mode='normal')
config.bind('B', 'spawn --userscript spinach-bookmarks.py  --tab', mode='normal')
# additional key bindings
config.bind('bt', 'spawn --userscript spinach-bookmarks.py --tab', mode='normal')
config.bind('bw', 'spawn --userscript spinach-bookmarks.py --win', mode='normal')

# spinach's theme selector: switch user stylesheets
config.bind('<Space>s', 'spawn --userscript spinach-themes.py', mode='normal')
