#!/bin/bash

# Clearing formats of ffuf output files

# Define the input file
ffuf_file1=ffuf-extension.$ports.$target_name

# Use sed to remove the sequence and overwrite the file
# Use sed to remove the sequence and overwrite the file
sed -i 's/\x1b\[2K//g' "$ffuf_file1" # Used to replace front garbage
sed -i 's/\x1b\[0m//g' "$ffuf_file1" # Used to replace last garbage
#sed -i '/^$/d' "$input_file"
#grep -v '^$' "$input_file" > temp && mv temp "$input_file"
sed -i 's/\r//g' "$ffuf_file1" # Used to replace blank lines

ffuf_file2=ffuf-raft-files.$ports.$target_name
sed -i 's/\x1b\[2K//g' "$ffuf_file2"
sed -i 's/\x1b\[0m//g' "$ffuf_file2"
sed -i 's/\r//g' "$ffuf_file2"
