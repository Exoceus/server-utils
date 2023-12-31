#!/usr/bin/env bash

source godaddy_api.sh

LOG_PATH="/var/log/ip-tracker"

track_ip() {
	domain=$1
	record_name=$2

	echo "Initializing check for record $record_name and domain $domain."

	current_ip=$(get_dns_ip "$domain" "$record_name")

	echo "Got $current_ip as IP in GoDaddy."

	new_ip=$(curl --silent -6 icanhazip.com)

	echo "Got $new_ip as IP for machine."

	if [[ "$current_ip" != "ERROR" && "$current_ip" != "" ]]; then
		if [ "$new_ip" != "$current_ip" ]; then
			status=$(update_dns_ip "$domain" "$record_name" "$new_ip")
			if [ "$status" == "200" ]; then
				echo "SUCCESS. Updated IP from $current_ip to $new_ip"
			else
				echo "ERROR"
			fi
		else
			echo "No change in IP. IP is $current_ip"
		fi
	else
		echo "ERROR: wasn't able to get current IP from GoDaddy. Need to setup Email alert"
	fi
}

ip_track_wrapper() {
	result=$(track_ip $1 $2)

	datetime=$(date +%Y-%m-%dT%H:%M:%S)

	echo -e "\n"
	echo "> TIMESTAMP: $datetime"
	echo "$result"
}

track_ip_main() {
	logs=$(ip_track_wrapper $1 $2)

	if [ ! -d ${LOG_PATH} ]; then
		mkdir -p ${LOG_PATH}
	fi
	echo "$logs" >>"$LOG_PATH/log.txt"
}
