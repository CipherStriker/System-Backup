#!/bin/bash

# Function to show a progress bar
show_progress_bar() {
    local pid=$1
    local index=$2
    local delay=0.1
    local progress=0
    local max=50
    local bar='=================================================='
    local spaces='                                                  '

    while kill -0 "$pid" 2>/dev/null; do
        progress=$(( (progress + 1) % (max + 1) ))
        done_length=$((progress * max / 100))
        undone_length=$((max - done_length))

        # Move the cursor to the appropriate line
        tput cup $index 0

        # Print the progress bar
        printf "Command $index: [%.*s%.*s] %d%%" "$done_length" "$bar" "$undone_length" "$spaces" "$((progress * 2))"
        sleep $delay
    done

    # Move the cursor to the appropriate line
    tput cup $index 0

    # Print the completed progress bar
    printf "Command $index: [${bar}] 100%% - Done!\n"
}

# Function to execute a command and save its output to a file
execute_command() {
    local command=$1
    local output_file=$2

    eval "$command" &> "$output_file"
}

# Clear the screen
clear

# List of long-running commands (replace these with your actual commands)
commands=(
    "sleep 10 && echo 'Command 1 completed'"
    "sleep 15 && echo 'Command 2 completed'"
    "sleep 20 && echo 'Command 3 completed'"
)

# Execute each command in the background, save its output, and show a progress bar
pids=()
output_files=()
for i in "${!commands[@]}"; do
    output_file="output_command_$((i+1)).txt"
    output_files+=("$output_file")

    # Print starting message at the correct position
    tput cup $((i+1)) 0
    echo "Starting command $((i+1)): ${commands[$i]}"

    # Run the command in the background and save its output
    execute_command "${commands[$i]}" "$output_file" &
    pids+=($!)
done

# Show a progress bar for each background command in parallel
for i in "${!pids[@]}"; do
    show_progress_bar "${pids[$i]}" "$((i+1))" &
done

# Wait for all background processes to complete
wait

# Move the cursor below the progress bars
tput cup $((${#commands[@]} + 1)) 0

echo "All commands completed."

# Display the output of each command
for i in "${!output_files[@]}"; do
    echo -e "\nOutput of command $((i+1)) (${commands[$i]}):"
    cat "${output_files[$i]}"
done
