#!/bin/bash

# Check if the script is running as root
if [ "$(id -u)" -ne 0 ]; then
  echo "This script must be run as root."
  exit 1
fi

# Check if the required arguments are provided
if [ $# -lt 2 ]; then
  echo "Usage: $0 <username> <password>"
  exit 1
fi

# Get the username and password from arguments
username="$1"
password="$2"

# Check if the user already exists
if id -u "$username" >/dev/null 2>&1; then
  echo "User '$username' already exists."
  exit 1
fi

# Create the new user with a home directory
useradd -m "$username"

# Set the user's password securely
echo "$username:$password" | chpasswd

# Provide feedback to the user
echo "User '$username' has been created with the specified password."
