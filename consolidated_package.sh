#!/bin/bash

#Fetch server list
ansible-playbook acom.yml -e 'cli_hosts=tag_Name_upperthrust-bastion01:tag_Name_test-ut0201'

#!/bin/bash

# Run awk on each package file and remove specific lines
for file in installed_packages_*.txt; do
    # Apply awk command on each package file
    awk '{ if (NR > 5 && $1 != "Desired=Unknown/Install/Remove/Purge/Hold" && $2 != "|") print $2 " " $3 }' "$file" > "$file.tmp"

    # Replace the original file with the processed content (excluding certain lines)
    mv "$file.tmp" "$file"
done

# Merge all package files into one
cat installed_packages_*.txt > merged_packages.txt

# Extract unique packages
sort merged_packages.txt | uniq > unique_packages.txt

# Clean up - Remove merged file
rm merged_packages.txt
