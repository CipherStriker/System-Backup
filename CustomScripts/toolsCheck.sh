#!/bin/bash

# Define color codes
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RESET='\033[0m'
RED='\033[0;31m'

# List of tools to check
SystemTOOLS=(
	zsh
	sudo
    curl
    wget
    git
    ping # iputils-ping
    nano
    nala # Alternate Package Manager
    lynx
    lftp
    python3
    docker
    netcat
    pip3
    go # Golang-go
    batcat # Alternative to cat command
    tmux
)
PentestTOOLS=(
    nmap
    nikto
    ffuf
    gobuster
    dirsearch
    nuclei
    whatweb
    wafw00f
    whatwaf
    gitTools
    jwt_tools
    ghauri
    Host-Header-Injection-Vulnerability-Scanner
)

echo "Checking installed system tools..."
echo "--------------------------------"

for tool in "${SystemTOOLS[@]}"; do
    if command -v "$tool" >/dev/null 2>&1; then
        echo -e "${GREEN}[✓]${RESET} $tool is installed"
    else
        echo -e "${RED}[✗]${RESET} $tool is NOT installed"
    fi
done

echo "--------------------------------"
echo "Check completed."
echo ""
#---------------------------------------------#
echo "Checking installed pentest tools..."
echo "--------------------------------"

for tool in "${PentestTOOLS[@]}"; do
    if command -v "$tool" >/dev/null 2>&1; then
        echo -e "${GREEN}[✓]${RESET} $tool is installed"
    else
        echo -e "${RED}[✗]${RESET} $tool is NOT installed"
    fi
done

echo "--------------------------------"
echo "Check completed."

# build-essential → A toolbox (compiler, make, headers)
# DKMS → An automatic mechanic that fixes drivers whenever the engine (kernel) changes

for pkg in build-essential dkms; do
  if dpkg -s "$pkg" &>/dev/null; then
    echo -e "${GREEN}[✓]${RESET} $pkg is installed"
  else
    echo -e "${RED}[✗]${RESET} $pkg is NOT installed"
  fi
done
