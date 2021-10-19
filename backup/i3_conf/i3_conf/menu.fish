#!/usr/bin/fish
cat /dev/null > /tmp/spinach_i3_sysctrl.py.log
date > /tmp/spinach_i3_sysctrl.py.log
python ~/.config/i3/spinach_i3_sysctrl.py $argv
