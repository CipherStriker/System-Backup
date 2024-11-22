#!/bin/bash

#Color Codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

#read -p "Target Name: " target_name
#read -p "Target URL: " IP

# Where ffuf files are present
cd ~/newVulnHub/$target_name
# Reading lines from http.port and https.port
if [ -z "$HTTP_PORT" ];then
	echo "No http port to run the script..."
	echo "Checking for https ports"
else

	for ports in $(cat http.port); do
	echo ""
	echo -e "${GREEN}Scanning for HTML Comments on port $ports...${NC}"
	cat ffuf-extension.$ports.$target_name > fileCombine:$ports.txt
	cat ffuf-raft-files.$ports.$target_name >> fileCombine:$ports.txt
	# Extracting files
	cat fileCombine:$ports.txt | grep "Status: 200" | awk '{print $1}' >> FileList1:$ports.txt && cat FileList1:$ports.txt | sort | uniq >> finalFileList1:$ports.txt
	# Extracting directories
	cat fileCombine:$ports.txt | grep -E "Status: 301|Status: 302" | awk '{print $1}' >> FileList2:$ports.txt && cat FileList2:$ports.txt | sort | uniq >> finalDirectoryList2:$ports.txt
	# grep can also is use as <grep -E 'Status: (301|302)'>


	echo -e "${GREEN}# For Files${NC}"
	#for lines in $(cat finalFileList1:$ports.txt); do echo ${GREEN}$lines${NC} && curl -s "http://$IP:$ports/$lines" | grep --color=auto "<\!--" ; done
	for lines in $(cat finalFileList1:$ports.txt); do echo $lines && curl -s "http://$IP:$ports/$lines" | grep --color=auto "<\!--" ; done
	echo ""
	echo -e "${GREEN}# For Directories${NC}"
	#for lines in $(cat finalDirectoryList2:$ports.txt); do echo ${BLUE}$lines${NC} && curl -s "http://$IP:$ports/$lines/" | grep --color=auto "<\!--" ; done;
	for lines in $(cat finalDirectoryList2:$ports.txt); do echo $lines && curl -s "http://$IP:$ports/$lines/" | grep --color=auto "<\!--" ; done;
	done
fi
rm fileCombine* FileList* final*
