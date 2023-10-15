#!/bin/bash

# Remove Ubuntu Pro license and automatically answer "yes" to the confirmation prompt
yes | /usr/bin/ua detach
# Check if the detachment was successful (exit code 0 indicates success)
if [ $? -eq 0 ]; then
  echo "Ubuntu Pro license removed successfully."
else
  echo "Failed to remove Ubuntu Pro license."
fi

# Update the system
apt update

# Check the system release name
release_name=$(lsb_release -cs)

# Check if the system is running Ubuntu 18.04 LTS (Bionic Beaver)
if [ "$release_name" == "bionic" ]; then
  echo "System is now running Ubuntu 18.04 LTS (Bionic Beaver)."
else
  echo "System is still running with ubuntu pro subscription."
fi
