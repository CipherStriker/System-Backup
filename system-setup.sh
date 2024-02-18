#!/bin/bash

cd ~
mkdir .dotfiles Allendevaux Exploits CustomCodes Post-Exploitation Pre-Exploitation Offensive-Security Github-Repos Wordlist

cd .dotfiles
wget "https://github.com/CipherStriker/System-Setup/blob/main/.dotfiles(aliases)/directory-fuzzer"
wget "https://github.com/CipherStriker/System-Setup/blob/main/.dotfiles(aliases)/misc"
wget "https://github.com/CipherStriker/System-Setup/blob/main/.dotfiles(aliases)/scanning-aliases"
wget "https://github.com/CipherStriker/System-Setup/blob/main/.dotfiles(aliases)/system-aliases"
wget "https://github.com/CipherStriker/System-Setup/blob/main/.dotfiles(aliases)/to-be-sorted"

cd ~
cd CustomCodes
wget "https://github.com/CipherStriker/System-Setup/blob/main/CustomCodes/url-decode.py"

# cd ~
# cd Wordlist
# git clone https://github.com/danielmiessler/SecLists.git



# Source the alias files
cd ~
echo "source ~/.dotfiles/directory-fuzzer" >> .zshrc
echo "source ~/.dotfiles/scanning-aliases" >> .zshrc
echo "source ~/.dotfiles/system-aliases" >> .zshrc
echo "source ~/.dotfiles/to-be-sorted" >> .zshrc
echo "source ~/.dotfiles/misc" >> .zshrc
