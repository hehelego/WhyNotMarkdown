# load the autoconfig file: $HOME/.config/qutebrowser/autoconfig.yml
config.load_autoconfig()

# enable HiDPI support
config.set('qt.highdpi', True)

# enable GPU acceleration
# see [https://github.com/qutebrowser/qutebrowser/discussions/6573, https://github.com/qutebrowser/qutebrowser/issues/5378]
config.set('qt.args',['ignore-gpu-blacklist','enable-gpu-rasterization','enable-native-gpu-memory-buffers','num-raster-threads=4','enable-accelerated-video-decode'])

# use socks5 proxy
config.set('content.proxy', 'socks://127.0.0.1:1089')

# render the page in dark theme if possible
config.set('colors.webpage.preferred_color_scheme','dark')

# external editor command
#  config.set('editor.command', ["codium", "--goto", "{file}:{line}:{column0}"])
config.set('editor.command', ["alacritty", "-e", "nvim", "-c", "normal {line}G{column0}|", "--", "{file}"])

# externel file selector command
config.set('fileselect.folder.command', ["alacritty", "-e", "ranger", "--choosedir={}"])
config.set('fileselect.single_file.command', ["alacritty", "-e", "ranger", "--choosefile={}"])
config.set('fileselect.multiple_files.command', ["alacritty", "-e", "ranger", "--choosefiles={}"])

# keepassxc integration
config.bind('<Alt-u>', 'spawn --userscript qute-keepassxc --key qutebrowser-keepassxc-connection-233', mode='insert')
config.bind('<Space>pw', 'spawn --userscript qute-keepassxc --key qutebrowser-keepassxc-connection-233', mode='normal')
