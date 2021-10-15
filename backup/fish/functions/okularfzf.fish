function okularfzf
	okular (fzf -m) &
	disown $last_pid
end
