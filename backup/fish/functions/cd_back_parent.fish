function cd_back_parent
	set count 1
	if test -n "$argv"
		set count $argv[1]
	end
	for i in (seq $count)
		cd ..
	end
end
