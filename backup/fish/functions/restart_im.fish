function restart_im
	pkill fcitx5
	fcitx5 &
	disown $last_pid
end
