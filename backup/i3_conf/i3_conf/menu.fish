#!/usr/bin/fish
set log_file /tmp/spinach_fzfmenu.py.log
cat /dev/null > $log_file
date > $log_file
~/.config/i3/spinach_i3_sysctrl_ng.py $argv
