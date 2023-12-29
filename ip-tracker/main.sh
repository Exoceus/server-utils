#!/usr/bin/env bash

OUTPUT_DIR="/var/log/jatin/ip-tracker"

date_year=$(date +"%Y")
date_month=$(date +"%m")
date_day_time=$(date +"%d-%T")
public_ip=$(curl -4 icanhazip.com 2>/dev/null)

# store as log
path_to_log_folder="$OUTPUT_DIR/data/$date_year/$date_month"

if [ ! -d ${path_to_log_folder} ]; then
	mkdir -p ${path_to_log_folder}
fi

echo "$public_ip" >"$path_to_log_folder/$date_day_time.log"

# compare with currently stored ip
path_to_ip="$OUTPUT_DIR/current_ip.txt"

if [ -f ${path_to_ip} ]; then

	previous_ip=$(cat $path_to_ip)

	if [ "$public_ip" != "$previous_ip" ]; then

	else
		echo "No change in IP. IP is $public_ip"
	fi
else
	echo "$public_ip" >"$path_to_ip"
fi

function function_name {
	commands
}
