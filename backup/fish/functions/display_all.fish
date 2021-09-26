function display_all
	xrandr --output eDP --mode 2560x1600 --rate 60 --gamma 1:1:1 --dpi 192 --set TearFree on
	xrandr --output DisplayPort-0 --mode 3840x2160 --rate 60 --gamma 1:1:1 --dpi 192 --set TearFree on --left-of eDP
	xrandr --output DisplayPort-1 --mode 3840x2160 --rate 60 --gamma 1:1:1 --dpi 192 --set TearFree on --right-of eDP
	setbg
end
