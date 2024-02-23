#!/bin/bash

# Function to generate the formatted output
generate_output() {
    echo "------------------------------------------------------------------------------------------------------------------------------------------------"
    printf " %-15s | %-7s | %-8s | %-16s | %-15s | %-12s | %-16s | %-16s | %-16s\n" "IP" "Dist" "Version" "Kernel Version" "PRO Status" "Kernel Status" "Last Upgrade Date" "Status of Unattended service" "Livepatch Interval"
    echo "------------------------------------------------------------------------------------------------------------------------------------------------"

    while IFS=' | ' read -r ip dist version kernel_version os_status; do
        printf " %-15s | %-7s | %-8s | %-16s | %-15s | %-15s | %-16s | %-16s | %-16s\n" "$ip" "$dist" "$version" "$kernel_version" "$os_status" "$kernel_status" "$date" "$unaatn" "$livepatch"
    done
}

# Specify the path to the text file
file_path="/home/saswat/upgrade/new_kernel.txt"  # Replace with the actual path to your file

# Check if the file exists
if [ -f "$file_path" ]; then
    # Read content from the file and generate the formatted output
    cat "$file_path" | generate_output
else
    echo "File not found at the specified path: $file_path"
fi
