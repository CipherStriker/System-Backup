#!/bin/bash

source $HOME/System-Planner/System-Setup/CustomScripts/ColorCodes/BashColorCodes-Type2.sh

read -p "Target Name: " target_name
read -p "Target IP: " IP

cd ~/newVulnHub && mkdir $target_name
cd $target_name

# Make directory for target analysis
mkdir Analysis

echo ""
echo -e "${GREEN}Scanning for open TCP ports...${NC}"
echo -e "sudo nmap -sV -Pn -p- $IP | tee short-scan.nmap.$target_name" > short-scan.nmap.$target_name
sudo nmap -sV -Pn -p- $IP >> short-scan.nmap.$target_name

# Find Ports
OPEN_PORTS=$(cat short-scan.nmap.$target_name | grep tcp | grep open | cut -d'/' -f1 | paste -sd ',') # output : 22,80,8080
HTTP_PORT=$(cat short-scan.nmap.$target_name | grep tcp | grep open | grep -w http | cut -d'/' -f1) # output : 80 8081
HTTPS_PORT=$(cat short-scan.nmap.$target_name | grep tcp | grep open | grep -w https | cut -d'/' -f1) # output : 80 8081

# Start of the Scans
echo -e "${GREEN}Starting default Nmap scan...${NC}"
echo -e "${GREEN}sudo nmap -sC -sV -Pn -p $OPEN_PORTS $IP | tee nmap.$target_name${NC}" > nmap.$target_name
echo ""
sudo nmap -sC -sV -Pn -p $OPEN_PORTS $IP >> nmap.$target_name

# Creating files for http and https ports
echo $HTTP_PORT | tr ' ' '\n' >> http.port # Changing horizontal to vertical format
echo $HTTPS_PORT | tr ' ' '\n' >> https.port # Changing horizontal to vertical format


# Start Nikto Scan for HTTP ports
if [ -z "$HTTP_PORT" ];then # Checks if the output is empty
	echo "No http port to run nikto..."
	echo "Checking for https ports"
else

	for ports in $(cat http.port); do
	echo -e "${GREEN}Starting Nikto scan on port $ports...${NC}"
	nikto -host $IP -p $ports >> nikto:$ports.$target_name;
	done
fi

# Starting Nikto for HTTPS ports
if [ -z "$HTTPS_PORT" ];then # Checks if the output is empty
	echo "No https port to run nikto..."
else

	for ports in $(cat https.port); do
	echo -e "${GREEN}Starting Nikto scan on port $ports...${NC}"
	nikto -host $IP -p $ports >> nikto:$ports.$target_name;
	done
fi

# ----- Ending Nikto Scans------
echo ""
echo "------Basic recon completed------"
echo ""
echo "------Starting Enumearation------"
echo ""
#echo "Starting Dirb"

# Starting Dirb Scan for HTTP ports
if [ -z "$HTTP_PORT" ];then
	echo "No http port to run dirb..."
	echo "Checking for https ports"
else

	for ports in $(cat http.port); do
	echo -e "${GREEN}Starting dirb scan on port $ports...${NC}"
	dirb http://$IP:$ports/ -r -o dirb:$ports.$target_name;
	done
fi

# Starting Dirb Scan for HTTPS ports
if [ -z "$HTTPS_PORT" ];then
	echo "No https port to run dirb..."
else

	for ports in $(cat https.port); do
	echo -e "${GREEN}Starting dirb scan on https port $ports...${NC}"
	dirb https://$IP:$ports/ -r -o dirb:$ports.$target_name;
	done
fi

#------Dirb Scan Complete-------#


# Starting Dirsearch for HTTP ports
echo ""
if [ -z "$HTTP_PORT" ];then
	echo "No http port to run Dirsearch..."
	echo "Checking for https ports"
else

	for ports in $(cat http.port); do
	echo -e "${GREEN}Starting Dirsearch on port $ports...${NC}"
	echo ""
	dirsearch -u http://$IP:$ports/ -t 100 -o dirsearch:$ports.$target_name --format=plain;
	done
fi
# Starting Dirsearch for HTTPS ports
echo ""
if [ -z "$HTTPS_PORT" ];then
	echo "No https port to run Dirsearch..."
else

	for ports in $(cat https.port); do
	echo -e "${GREEN}Starting Dirsearch on https port $ports...${NC}"
	echo ""
	dirsearch -u https://$IP:$ports/ -t 100 -o dirsearch:$ports.$target_name --format=plain;
	done
fi

# Starting Gobuster for HTTP ports
echo ""
if [ -z "$HTTP_PORT" ];then
	echo "No http port to run Gobuster..."
	echo "Checking for https ports"
else

	for ports in $(cat http.port); do
	echo -e "${GREEN}Starting Gobuster on port $ports...${NC}"
	echo ""
	gobuster dir -u http://$IP:$ports/ -w ~/tools/wordlist/directory-list-2.3-medium.txt -x .php,.txt -t 100 | tee gobuster:$ports.$target_name;
	done
fi

# Starting Gobuster for HTTPS ports
echo ""
if [ -z "$HTTPS_PORT" ];then
	echo "No https port to run Gobuster..."
else

	for ports in $(cat https.port); do
	echo -e "${GREEN}Starting Gobuster on port $ports...${NC}"
	echo ""
	gobuster dir -u http://$IP:$ports/ -w ~/tools/wordlist/directory-list-2.3-medium.txt -x .php,.txt -t 100 | tee gobuster:$ports.$target_name;
	done
fi
# ------ Ending Dirsearch, Gobuster-------#
# ------ Starting FFUF ----------#
echo ""
if [ -z "$HTTP_PORT" ];then
	echo "No http port to run FFUF..."
else
	for ports in $(cat http.port); do
	echo -e "${GREEN}Starting FFUF with extension (PHP, TXT) on port $ports...${NC}"
	#echo "Command :"
	#TODO display command into the respective output file
	ffuf -u "http://$IP:$ports/FUZZ" -w ~/tools/wordlist/directory-list-2.3-medium.txt -e .php,.html | tee ffuf-extension.$ports.$target_name
	echo ""
	echo ""
	echo -e "${GREEN}Starting FFUF with raft file list on port $ports...${NC}"

	ffuf -u "http://$IP:$ports/FUZZ" -w ~/tools/wordlist/raft-medium-files-lowercase.txt | tee ffuf-raft-files.$ports.$target_name
	echo ""
	echo ""
	done
fi

# Starting FFUF for HTTPS ports
echo ""
if [ -z "$HTTPS_PORT" ];then
	echo "No https port to run FFUF..."
else
	for ports in $(cat http.port); do
	echo -e "${GREEN}Starting FFUF with extension (PHP, TXT) on port $ports...${NC}"
	#echo "Command :"
	ffuf -u "https://$IP:$ports/FUZZ" -w ~/tools/wordlist/directory-list-2.3-medium.txt -e .php,.html | tee ffuf-extension.$ports.$target_name
	echo ""
	echo ""
	echo -e "${GREEN}Starting FFUF with raft file list on port $ports...${NC}"
	ffuf -u "https://$IP:$ports/FUZZ" -w ~/tools/wordlist/raft-medium-files-lowercase.txt | tee ffuf-raft-files.$ports.$target_name
	echo ""
	done
fi

#echo "http ports :" | tee analysis.txt
#cat http.port | tee analysis.txt
#echo "" | tee analysis.txt
#echo "https ports" | tee analysis.txt
#cat https.port | tee analysis.txt
#echo "" | tee analysis.txt

source $HOME/System-Planner/System-Setup/CustomScripts/AutoRecon/fileProcessing.sh
source $HOME/System-Planner/System-Setup/CustomScripts/AutoRecon/targetAnalysis.sh | tee Analysis/targetAnalysis.txt
source $HOME/System-Planner/System-Setup/CustomScripts/AutoRecon/htmlComments_v1.1.sh | tee Analysis/htmlComments_v1.1.txt

cat Analysis/targetAnalysis.txt > Analysis/fullAnalysis.txt
cat Analysis/htmlComments_v1.1.txt >> Analysis/fullAnalysis.txt


# TODO
# FFUF : Have to do manually, bcz of no possible way to print banner information.
# Dirsearch : done
# Gobuster : Done
# Remove unwanted files
