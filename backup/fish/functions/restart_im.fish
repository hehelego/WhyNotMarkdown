function restart_im
	pkill fcitx5
	fcitx5 &
	disown (pgrep fcitx5)
end
