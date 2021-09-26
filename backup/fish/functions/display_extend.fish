function display_extend
	xrandr --output eDP --off
	xrandr --output DisplayPort-0 --mode 3840x2160 --rate 60 --gamma 1:1:1 --dpi 192 --set TearFree on
	xrandr --output DisplayPort-1 --mode 3840x2160 --rate 60 --gamma 1:1:1 --dpi 192 --set TearFree on
	setbg
end
