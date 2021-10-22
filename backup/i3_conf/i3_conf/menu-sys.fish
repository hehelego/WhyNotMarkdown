#!/usr/bin/fish
set log_file /tmp/spinach_sysmenu.log
cat /dev/null > $log_file
date > $log_file
~/.config/i3/spinach_sysmenu.py $argv
