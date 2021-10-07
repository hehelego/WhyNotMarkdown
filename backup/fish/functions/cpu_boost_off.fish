function cpu_boost_off
	echo 0 | sudo tee /sys/devices/system/cpu/cpufreq/boost
end
