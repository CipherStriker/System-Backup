#!/bin/zsh

# Define the commands to run
command1=sleep 5 && echo 'Command 1 completed'
command2=sleep 3 && echo 'Command 2 completed'

# Execute command1 in the background
$command1 &

# Execute command2 in the background
$command2 &

# Wait for both background processes to complete
wait

echo "Both commands completed"
