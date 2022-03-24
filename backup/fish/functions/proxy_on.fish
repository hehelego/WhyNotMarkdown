function proxy_on
	set -gx all_proxy       "socks5://127.0.0.1:1089"
	set -gx http_proxy      "http://127.0.0.1:8889"
	set -gx https_proxy     "$http_proxy"
	set -gx ftp_proxy       "$http_proxy"
	set -gx rsync_proxy     "$http_proxy"
	set -gx no_proxy        "localhost" "127.0.0.1" "localaddress" ".localdomain.com"
end

