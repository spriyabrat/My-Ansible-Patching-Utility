#!/bin/bash

# Extract parameters (assuming they are passed as arguments)
TAG=$1
PARAMETERS=$2

# Run the Ansible playbook with the extracted tag and parameters
ansible-playbook2 ansible2/adhoc_playbooks/view_console.yml --tags "$TAG" -e "$PARAMETERS"

# Display the contents of the text files
./ansible2/adhoc_playbooks/display_dashboard.sh
