#!/bin/bash

# Function to show a spinner
show_spinner() {
    local pid=$1
    local index=$2
    local delay=0.1
    local spinner='|/-\'
    while [ -d /proc/$pid ]; do
        for i in $(seq 0 3); do
            printf "\rCommand $index: [${spinner:$i:1}]"
            sleep $delay
        done
    done
    printf "\rCommand $index: Done!           \n"
}

# List of long-running commands (replace these with your actual commands)
commands=(
    "sleep 10"
    "sleep 20"
    "sleep 15"
)

# Execute each command in the background and show a spinner
pids=()
for i in "${!commands[@]}"; do
    echo "Starting command $((i+1)): ${commands[$i]}"
    ${commands[$i]} &
    pids+=($!)
done

# Show a spinner for each background command
for i in "${!pids[@]}"; do
    show_spinner "${pids[$i]}" "$((i+1))" &
done

# Wait for all background processes to complete
wait

echo "All commands completed."
