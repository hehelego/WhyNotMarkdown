#!/usr/bin/fish
set log_file /tmp/spinach_playerctl.log
cat /dev/null > $log_file
date > $log_file
alacritty -e ~/.config/i3/spinach_playerctl.py --show mixed $argv
