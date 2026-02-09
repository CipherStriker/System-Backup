#!/bin/bash

for line in $(cat pdf-newfile.txt); do
    scan_value=$(echo $line | awk -F ':' '{print $3}'); # Pick the scan value
    encoded_asset_name=$(echo $line | awk -F ':' '{print $2}'); # Pick the encoded asset value
    report_name=$(jq -nr --arg str "$encoded_asset_name" '$str | @urid') # Decode the asset value
    curl -X POST -H "X-Requested-With: curl" \
     -b "QualysSession=bd560b93948c5c6d9128180fd9ff7b6a" \
     "https://qualysapi.qg2.apps.qualys.com/api/2.0/fo/report/?action=fetch&id=$scan_value" \
     --output "$report_name.pdf"
done
