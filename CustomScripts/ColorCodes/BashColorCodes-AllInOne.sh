#!/bin/bash

#Color Codes : resets all text attributes and then changes the text color
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color


# Color Codes : simply changes the text color to green
# Foreground colors
echo -e "\e[31mThis is red text\e[0m"
echo -e "\e[32mThis is green text\e[0m"
echo -e "\e[33mThis is yellow text\e[0m"
echo -e "\e[34mThis is blue text\e[0m"
echo -e "\e[35mThis is magenta text\e[0m"
echo -e "\e[36mThis is cyan text\e[0m"
echo -e "\e[37mThis is white text\e[0m"

# Background colors
echo -e "\e[41mThis has a red background\e[0m"
echo -e "\e[42mThis has a green background\e[0m"
echo -e "\e[43mThis has a yellow background\e[0m"
echo -e "\e[44mThis has a blue background\e[0m"
echo -e "\e[45mThis has a magenta background\e[0m"
echo -e "\e[46mThis has a cyan background\e[0m"
echo -e "\e[47mThis has a white background\e[0m"

# Bright foreground colors
echo -e "\e[91mThis is bright red text\e[0m"
echo -e "\e[92mThis is bright green text\e[0m"
echo -e "\e[93mThis is bright yellow text\e[0m"
echo -e "\e[94mThis is bright blue text\e[0m"
echo -e "\e[95mThis is bright magenta text\e[0m"
echo -e "\e[96mThis is bright cyan text\e[0m"
echo -e "\e[97mThis is bright white text\e[0m"

# Bright background colors
echo -e "\e[101mThis has a bright red background\e[0m"
echo -e "\e[102mThis has a bright green background\e[0m"
echo -e "\e[103mThis has a bright yellow background\e[0m"
echo -e "\e[104mThis has a bright blue background\e[0m"
echo -e "\e[105mThis has a bright magenta background\e[0m"
echo -e "\e[106mThis has a bright cyan background\e[0m"
echo -e "\e[107mThis has a bright white background\e[0m"

# Text formatting
echo -e "\e[1mThis is bold text\e[0m"
echo -e "\e[4mThis is underlined text\e[0m"
echo -e "\e[0mThis resets all formatting"
