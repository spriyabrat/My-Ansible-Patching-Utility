#!/bin/bash

# Extract parameters (assuming they are passed as arguments)
TAG=$1
PARAMETERS=$2

# Run the Ansible playbook with the extracted tag and parameters
ansible-playbook -i inventory.yml view_console.yml --tags "$TAG" -e "$PARAMETERS"

# Display the contents of the text files
./display.sh
