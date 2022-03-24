function proxy_off
	set vars "all_proxy" "http_proxy" "https_proxy" "ftp_proxy" "rsync_proxy" "no_proxy"

	for v in $vars
		if set -q $v
			set -e $v
		end
	end
end

