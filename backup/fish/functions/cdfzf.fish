function cdfzf
	set target (fd --hidden --type directory | fzf)
	if test -n "$target"
		cd $target
	end
end
