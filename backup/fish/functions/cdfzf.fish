function cdfzf
	cd (rg --hidden --sort-files --files --null 2> /dev/null | xargs -0 dirname | uniq | fzf)
end
