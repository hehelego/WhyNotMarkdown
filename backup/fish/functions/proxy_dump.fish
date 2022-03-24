function proxy_dump
	set vars "all_proxy" "http_proxy" "https_proxy" "ftp_proxy" "rsync_proxy" "no_proxy"
	
	for v in $vars
		if set -q $v
			set -S $v
		else
			echo -e "\$$v \tis not set"
		end
		echo ""
	end
end
