function qb-private
	qutebrowser --temp-basedir --target private-window --config-py ~/.config/qutebrowser/config.py > /tmp/qb-private.log.stdout 2> /tmp/qb-private.log.stderr &
	disown (pgrep qutebrowser)
end
