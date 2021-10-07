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
config.set('content.proxy', 'socks://127.0.0.1:1089')
config.set('fonts.default_family', 'monospace')
config.set('scrolling.smooth', True)
config.set('qt.highdpi', True)

# enable GPU acceleration
# see https://github.com/qutebrowser/qutebrowser/discussions/6573
# see https://github.com/qutebrowser/qutebrowser/issues/5378]
config.set('qt.args', [
               'ignore-gpu-blacklist',
               'enable-gpu-rasterization',
               'enable-native-gpu-memory-buffers',
               'num-raster-threads=4',
               'enable-accelerated-video-decode'])

# command for external editor
# see https://github.com/qutebrowser/qutebrowser/issues/5340
#  config.set('editor.command', ['codium', '--goto', '{file}:{line}:{column0}'])
#  config.set('editor.command', ['alacritty', '-e', 'nvim', '-c', 'normal {line}G{column0}|', '--', '{file}'])
#  config.set('editor.command', ['kate', '--startanon', '--line', '{line}', '--column', '{column}', '{file}'])
#  config.set('editor.command', ['gedit','--new-window', '{file}','+{line}:{column}'])
config.set('editor.command', ["nvim-qt", "--nofork", "{file}", "--", "-c", "normal {line}G{column0}l"])



# command for external file selector
config.set('fileselect.folder.command', ['alacritty', '-e', 'ranger', '--choosedir={}'])
config.set('fileselect.single_file.command', ['alacritty', '-e', 'ranger', '--choosefile={}'])
config.set('fileselect.multiple_files.command', ['alacritty', '-e', 'ranger', '--choosefiles={}'])









##################################### PART B: key bindings #####################################


# tab-manipulation
config.bind('<Alt-j>', 'tab-next', mode='normal')
config.bind('<Alt-k>', 'tab-prev', mode='normal')
config.bind('<Alt-Shift-k>', 'tab-move -', mode='normal')
config.bind('<Alt-Shift-j>', 'tab-move +', mode='normal')
config.bind('<Alt-w>', 'tab-close', mode='normal')
config.bind('<Alt-p>', 'tab-pin', mode='normal')
config.bind('<Alt-m>', 'tab-mute', mode='normal')

# open developer tool
config.bind('<Space>td', 'devtools', mode='normal')
config.bind('<F12>', 'devtools', mode='normal')
config.bind('<F12>', 'devtools', mode='insert')

# toggle proxy
config.bind('<Space>tp', 'config-cycle -tp content.proxy socks://127.0.0.1:1089 none')

# edit url in external editor
config.bind('<Space>eu', 'edit-url', mode='normal')
# edit command in external editor
config.bind('<Space>ec', 'edit-command', mode='normal')

# keepassxc integration
config.bind('<Alt-u>', 'spawn --userscript qute-keepassxc --key qutebrowser-keepassxc-connection-233', mode='insert')
config.bind('<Space>pw', 'spawn --userscript qute-keepassxc --key qutebrowser-keepassxc-connection-233', mode='normal')

# reload config.py
config.bind('<Space>C', 'config-source', mode='normal')
# restart qutebrowser
config.bind('<Space>R', 'restart', mode='normal')

# run the developing userscript
config.bind('<Space>tt', 'spawn --userscript test.py', mode='normal')

# spinach's bookmarks selector
## [o, t, w] for open in current-tab, new-tab, new-window
## [a, e] for match-any-selected-tag, match-all-selected-tag
config.bind('<Space>boo', 'spawn --userscript spinach-bookmarks.py', mode='normal')
config.bind('<Space>boa', 'spawn --userscript spinach-bookmarks.py --tags-match-any', mode='normal')
config.bind('<Space>boe', 'spawn --userscript spinach-bookmarks.py --tags-match-every', mode='normal')
config.bind('<Space>btt', 'spawn --userscript spinach-bookmarks.py --tab', mode='normal')
config.bind('<Space>bta', 'spawn --userscript spinach-bookmarks.py --tab --tags-match-any', mode='normal')
config.bind('<Space>bte', 'spawn --userscript spinach-bookmarks.py --tab --tags-match-every', mode='normal')
config.bind('<Space>bww', 'spawn --userscript spinach-bookmarks.py --window', mode='normal')
config.bind('<Space>bwa', 'spawn --userscript spinach-bookmarks.py --window --tags-match-any', mode='normal')
config.bind('<Space>bwe', 'spawn --userscript spinach-bookmarks.py --window --tags-match-every', mode='normal')
# override the default key bindings
config.bind('b', 'spawn --userscript spinach-bookmarks.py', mode='normal')
config.bind('B', 'spawn --userscript spinach-bookmarks.py --tab', mode='normal')

# switch user stylesheets
# see https://github.com/alphapapa/solarized-everything-css
# see https://gitlab.com/dwt1/dotfiles/-/blob/master/.config/qutebrowser/config.py
# see qute://help/settings.html#content.user_stylesheets
config.bind('<Space>s', 'spawn --userscript spinach-themes.py',mode='normal')

# ZEN mode (hidding the tab-bar and status-bar)
config.bind('<Space>z', 'config-cycle -tp statusbar.show never always ;; config-cycle -tp tabs.show never always ;; clear-messages')
