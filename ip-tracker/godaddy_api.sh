#!/usr/bin/env bash

source godaddy_config.sh

# Makes API call to GO Daddy to fetch DNS for current IP
get_dns_ip() {
    domain=$1
    record_name=$2

    res=$(curl -s -w "%{http_code}" --request GET \
        --url "https://api.godaddy.com/v1/domains/$domain/records/$record_type/$record_name" \
        --header "Authorization: sso-key $api_key:$api_secret" \
        --header "accept: application/json" | {
        read body
        read code
        echo "$code $body"
    })

    status_code=$(echo "$res" | cut -d ' ' -f 1)

    if [[ ! -z "$status_code" && $status_code -eq 200 ]]; then
        stored_ip=$(echo "$res" | cut -d '[' -f 2 | cut -d ']' -f 1 | jq -r '.data')
        echo "$stored_ip"
    else
        echo "ERROR"
    fi
}

# Makes API call to GO Daddy to update DNS with new IP
update_dns_ip() {
    domain=$1
    record_name=$2
    new_ip=$3

    res=$(
        curl -s -w "%{http_code}" --request PUT \
            --url "https://api.godaddy.com/v1/domains/$domain/records/$record_type/$record_name" \
            --header "Authorization: sso-key $api_key:$api_secret" \
            --header "Content-Type: application/json" \
            --header "accept: application/json" \
            --data "[{\"data\": \"$new_ip\"}]" | {
            read code
            echo "$code"
        }
    )

    echo "$res"
}
