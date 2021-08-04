#!/bin/bash

ipaddr=$2

rm -rf ./logs/*
ssh -t integration-support-prod 'find /srv/integration/shares/solution_logs/com.sixt.corporate_procurement.cost_center_transfer/logs/error* -mtime -5 -exec scp {} maren@'$ipaddr':support/logs \;'

input="$1"

while IFS= read -r line
do
    correlationId=$(echo "$line" | jq -r '.properties.X_HYPHEN_Correlation_HYPHEN_ID')
    echo -e "$line" | jq -r '.body'| jq -rc '.body' 

while read -r line ; do
    echo $line | sed -re "s/^([^{]+)\{/{/g" | jq -rc '.message' | jq -rc '.message'| sed -re "s/^([^{]+)\{/{/g" -re "s/----.*//g" | jq -rc '.'

done < <(zgrep \"$correlationId\" ./logs/*)

done < "$input"
