#!/bin/bash

## Bash colours
YELLOW="\033[01;33m"
BLUE="\033[01;34m"
BOLD="\033[01;01m"
RED="\033[01;31m"
RESET="\033[00m"

# Check OS Type
os=$(uname -o)
echo '\e[0;32m'"Operating System Type :" $tecreset $os

# Check OS Release Version and Name
cat /etc/os-release | grep 'NAME\|VERSION' | grep -v 'VERSION_ID' | grep -v 'PRETTY_NAME' > /tmp/osrelease
echo -n '\e[0;32m'"OS Name :" $tecreset  && cat /tmp/osrelease | grep -v "VERSION" | cut -f2 -d\"
echo -n '\e[0;32m'"OS Version :" $tecreset && cat /tmp/osrelease | grep -v "NAME" | cut -f2 -d\"

# Check Architecture
architecture=$(uname -m)
echo   '\e[0;32m'"Architecture :" $tecreset $architecture

# Check Kernel Release
kernelrelease=$(uname -r)
echo   '\e[0;32m'"Kernel Release :" $tecreset $kernelrelease

# Check hostname
host=$(hostname)
echo '\e[0;32m'"Hostname :" $tecreset $host

# Check Internal IP
internalip=$(hostname -I)
echo   '\e[0;32m'"Internal IP :" $tecreset $internalip

# Check External IP
externalip=$(curl -s ipecho.net/plain;echo)
echo   '\e[0;32m'"External IP : $tecreset "$externalip

# Check DNS
nameservers=$(cat /etc/resolv.conf | sed '1 d' | awk '{print $2}')
echo   '\e[0;32m'"Name Servers :" $tecreset $nameservers 

# Check Logged In Users
who>/tmp/who
echo   '\e[0;32m'"Logged In users :" $tecreset && cat /tmp/who 

# Check RAM and SWAP Usages
free -h | grep -v + > /tmp/ramcache
echo   '\e[0;32m'"Ram Usages :" $tecreset
cat /tmp/ramcache | grep -v "Swap"
echo   '\e[0;32m'"Swap Usages :" $tecreset
cat /tmp/ramcache | grep -v "Mem"

# Check Disk Usages
df -h| grep 'Filesystem\|/dev/sda*' > /tmp/diskusage
echo   '\e[0;32m'"Disk Usages :" $tecreset 
cat /tmp/diskusage

# Check Load Average
loadaverage=$(top -n 1 -b | grep "load average:" | awk '{print $10 $11 $12}')
echo   '\e[0;32m'"Load Average :" $tecreset $loadaverage

# Check System Uptime
tecuptime=$(uptime | awk '{print $3,$4}' | cut -f1 -d,)
echo   '\e[0;32m'"System Uptime Days/(HH:MM) :" $tecreset $tecuptime

## External IP
echo -e "\n\n${YELLOW}[i]${RESET} External IP"
curl -sS -m 20 http://ipinfo.io/ip

## Checking OS
echo -e "\n\n${YELLOW}[i]${RESET} Checking OS"
cat /etc/issue
cat /etc/*-release

## Checking kernel version
echo -e "\n\n${YELLOW}[i]${RESET} Checking Kernel Version"
uname -a 
if [[ "$(uname -a)" == *"pae"* ]]; then
  echo -e "${RED}[-]${RESET} PAE kernel detected."
  sleep 2s
fi

# Unset Variables
unset tecreset os architecture kernelrelease internalip externalip nameserver loadaverage
