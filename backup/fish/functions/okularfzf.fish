function okularfzf
	set fzf_sel (fzf --cycle --multi --preview='stat {}')
	if test -n "$fzf_sel"
		okular $fzf_sel &
		disown $last_pid
	end
end
