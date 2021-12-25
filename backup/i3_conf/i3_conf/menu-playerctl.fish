#!/usr/bin/fish
set log_file /tmp/spinach_playerctl.log
cat /dev/null > $log_file
date > $log_file
~/.config/i3/spinach_playerctl.py --show mixed $argv
