#!/bin/bash

#source $HOME/System-Planner/System-Setup/CustomScripts/ColorCodes/BashColorCodes-Type2.sh

echo "--------Target Analysis--------"
echo ""
echo "Target : $target_name"
echo "IP :$IP"
echo ""
echo "http ports :"
cat http.port
echo ""
echo "https ports :"
cat https.port
echo ""
# FTP service analysis
echo ""
ftp_port=$(cat short-scan.nmap.$target_name | grep tcp | grep open | grep -w ftp | cut -d'/' -f1)
if [ -n "$ftp_port" ];then # Checks if the output is not empty

  proftpd=$(grep -o "ProFTPD 1.3.3c" short-scan.nmap.$target_name) # Greps the extract word

  if [ "$proftpd" = "ProFTPD 1.3.3c" ];then
    echo -e "FTP service ${RED}$proftpd${NC} detected (vulnerable)"
    echo -e "Exploit DB : ${GREEN}searchsploit -m linux/remote/15662.txt${NC}"
    echo -e "GitHub Link : ${GREEN}https://github.com/shafdo/ProFTPD-1.3.3c-Backdoor_Command_Execution_Automated_Script.git${NC}"

  else
    echo "Check verion exploit manually :"
    cat short-scan.nmap.$target_name | grep -w "ftp"
    echo ""

  fi

else
  echo "No FTP port was found"
fi

# FTP anonymous login
anon_login=$(cat nmap.$target_name | grep -o "Anonymous FTP login allowed")
if [ -n "$anon_login" ]; then
  echo -e "${RED}Anonymous FTP login allowed${NC}"
fi


# cgi-bin presence
echo ""
dirb_cgi=$(grep -o -m 1 "cgi-bin" dirb:$ports.$target_name)
if [ -z "$dirb_cgi" ]; then # Checks if the output is null or empty
  echo "No cgi-bin directory was found in DIRB scan"
else
  if [ "$dirb_cgi" = "cgi-bin" ]; then
    #statements
    echo -e "${RED}cgi-bin${NC} found in ${RED}dirb${NC} scan"
    echo "URL : $(grep -w "cgi-bin" dirb:$ports.$target_name)"
  fi
fi

echo ""
dirsearch_cgi=$(grep -o -m 1 "cgi-bin" dirsearch:$ports.$target_name)
if [ -z "$dirsearch_cgi" ]; then
  echo "No cgi-bin directory was found in DIRSEARCH scan"
else
  if [ "$dirsearch_cgi" = "cgi-bin" ]; then
    #statements
    echo -e "${RED}cgi-bin${NC} found in ${RED}dirsearch${NC} scan"
    echo "URL :"
    grep -w "cgi-bin" dirsearch:$ports.$target_name
  fi
fi

# Crawler
echo ""
echo -e "${GREEN}Crawling the website...${NC}"
echo ""
cat ffuf-extension.$ports.$target_name > findfolder:$ports.txt
cat ffuf-raft-files.$ports.$target_name >> findfolder:$ports.txt

cat findfolder:$ports.txt | grep "Status: 301" | awk '{print $1}' >> allFolder:$ports.txt

cat allFolder:$ports.txt | sort | uniq >> folderList:$ports.txt

for lines in $(cat folderList:$ports.txt); do
	#echo $lines
	findIndexing=$(curl -s "http://$IP:$ports/$lines/" | grep -o -i -m 1 "Index of")
	if [ "$findIndexing" = "Index of" ]; then
		echo -e "Found Indexing on ${RED}/$lines${NC}"
    echo "http://$IP:$ports/$lines/" | hakrawler -d 1 -u | grep -v "\?C="
	fi;
done
echo "------------------------------------------------"
rm findfolder* allFolder* folderList*
