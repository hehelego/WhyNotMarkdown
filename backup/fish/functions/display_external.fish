function display_external
	xrandr --output eDP --off
	xrandr --output DisplayPort-0 --mode 3840x2160 --rate 60 --gamma 1:1:1 --dpi 192 --set TearFree on --orientation normal
	xrandr --output DisplayPort-1 --mode 3840x2160 --rate 60 --gamma 1:1:1 --dpi 192 --set TearFree on --orientation normal
	setbg
end
