function display_internal
	xrandr --output eDP --mode 2560x1600 --rate 60 --gamma 1:1:1 --dpi 192 --set TearFree on --orientation normal
	xrandr --output DisplayPort-0 --off
	xrandr --output DisplayPort-1 --off
	setbg
end
