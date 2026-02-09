#!/bin/bash

counter=0
for line in $(cat file.txt); do
    ((counter++));
    var1=$(echo $line | awk -F ':' '{print $1}'); # Pick value scan/1234567.1234
    var2=$(echo $line | awk -F ':' '{print $2}'); # Pick encoded asset name
   # encoded_asset_name=$(jq -nr --arg str "$var2" '$str | @uri')
    curl -s -H "X-Requested-With: curl" -b "QualysSession=3937e7f57f7983c4c3ae5496a141649f" -d "action=launch&template_id=2369507&report_title=$var2&output_format=pdf&report_refs=$var1" "https://qualysapi.qg2.apps.qualys.com/api/2.0/fo/report/" --output response_body.xml; 
    var3=$(xmllint --xpath "//VALUE/text()" response_body.xml | sed 's/$/\n/')
    echo "$var1:$var2:$var3" >> pdf-newfile.txt
    if (( counter % 5 == 0 )); then
        echo "Reached 5 iterations. Sleeping for 2 minutes..."
        sleep 120
    fi
done
