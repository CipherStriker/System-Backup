#!/bin/bash

# Define color codes
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RESET='\033[0m'
RED='\033[0;31m'


file=$1
#filePath=$(locate $file)
filePath=$(dirname "$(realpath "$file")")
fileLocation="$filePath/$file"
# File to read from
FILE=$1

# Use a while loop with read to process each line correctly
while IFS= read -r line; do
    if [[ $line == *"200"* ]]; then
        # Color the line green if it contains "Status: 200"
        echo -e "${GREEN}${line}${RESET}"
    elif [[ $line == *"301"* ]]; then
        # Color the line blue if it contains "Status: 301"
        echo -e "${BLUE}${line}${RESET}"
    elif [[ $line == *"302"* ]]; then
        # Color the line blue if it contains "Status: 302"
        echo -e "${BLUE}${line}${RESET}"
    elif [[ $line == *"cgi-bin"* ]]; then
        # Color the line red if it contains "Status: 500"
        echo -e "${RED}${line}${RESET}"
    # Specially for Dirbuster scan result
    elif [[ $line == *"DIRECTORY"* ]]; then
        # Color the line blue if it contains "DIRECTORY"
        echo -e "${BLUE}${line}${RESET}"
    else
        # Print the line normally if it does not contain "Status: 200"
        echo "$line"
    fi
done < "$fileLocation"
