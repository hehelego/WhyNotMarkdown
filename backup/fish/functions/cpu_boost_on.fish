function cpu_boost_on
	echo 1 | sudo tee /sys/devices/system/cpu/cpufreq/boost
end
