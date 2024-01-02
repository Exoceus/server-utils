#!/usr/bin/env bash

# this text file should have each line in format of: "<domain> <record_name>"
# also must end with empty line!
# WARNING - this must point to the file with records to update and must be in the same folder as main.sh
domains_file="domains_config.txt"

cd $(dirname "${BASH_SOURCE[0]}")
source track_ip.sh

# iteratively calls the track_ip function for all domains
while read line; do
    domain=$(echo "$line" | cut -d ' ' -f 1)
    record_name=$(echo "$line" | cut -d ' ' -f 2)
    track_ip_main $domain $record_name
done <"$domains_file"
