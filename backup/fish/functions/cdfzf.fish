function cdfzf
	set target (fd -H --type directory | fzf)
	if test -n "$target"
		cd $target
	end
end
