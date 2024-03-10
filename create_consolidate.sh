#!/bin/bash

# Check if the number of arguments is correct
if [ "$#" -ne 4 ]; then
  echo "Usage: $0 <cli_hosts> <cli_region>"
  exit 1
fi

# Assigning the arguments to variables
cli_hosts=$2
cli_region=$4

# Specify the output directory
output_directory="/tmp/output_directory"
mkdir -p "$output_directory"

# Running the Ansible playbook
ansible-playbook fetch_package_list.yml -e "cli_hosts=$cli_hosts cli_region=$cli_region"
#ansible-playbook aal.yml -e "cli_hosts=$1"

# Run awk on each package file and remove specific lines in /tmp directory
for pack_file in /tmp/output_directory/installed_packages_*.txt; do
  if [ -f "$pack_file" ]; then
    # Apply awk command on each package file
    awk '{ if (NR > 5 && $1 != "Desired=Unknown/Install/Remove/Purge/Hold" && $2 != "|") print $2 " " $3 }' "$pack_file" > "$pack_file.tmp"

    # Replace the original file with the processed content (excluding certain lines)
    mv "$pack_file.tmp" "$pack_file"

    # Extract the file name without the directory path
    filename=$(basename "$pack_file")

    # Create CSV file from the processed content of each file in /tmp directory
    if [ -n "$filename" ]; then
      awk '{print $1 "," $2}' "$pack_file" > "/tmp/${filename%.txt}.csv"
    fi
  fi
done

# Merge all package files into one
cat /tmp/output_directory/installed_packages_*.txt > /tmp/output_directory/merged_packages.txt

# Extract unique packages
sort /tmp/output_directory/merged_packages.txt | uniq > /tmp/output_directory/unique_packages.txt

# Extract in csv
awk '{print $1 "," $2}' /tmp/output_directory/unique_packages.txt > /tmp/output_directory/unique_packages.csv

# Delete the original .txt files after creating the .csv in /tmp directory
#for file in /tmp/my_output_directory/installed_packages_*.txt; do
#  if [ -f "$file" ]; then
#    rm "$file"
#  fi
#done

# Clean up - Remove merged file and unique_packages.txt in /tmp directory
rm -rf /tmp/output_directory/merged_packages.txt /tmp/output_directory/unique_packages.txt

# Loop through each sas_dependencies file in /tmp directory
for input_file in /tmp/output_directory/dependencies*.txt; do
  # Output file corresponding to the input
  output_file="${input_file%.txt}.csv"

  # Create CSV file and add headers
  echo "Package,Dependency" > "$output_file"

  # Read each line in the input file
  while IFS= read -r line; do
    # Extract package name
    package=$(echo "$line" | cut -d ' ' -f 1)

    # Extract dependencies after the first comma
    dependencies=$(echo "$line" | sed 's/^[^ ]* //')

    # Replace commas between dependencies with spaces
    dependencies=$(echo "$dependencies" | sed 's/,/ /g')

    # Write to CSV file
    echo "$package,$dependencies" >> "$output_file"
  done < "$input_file"

done

# Merge all package files into one
cat /tmp/output_directory/dependencies*.csv > /tmp/output_directory/merged_dependencise.csv

# Extract unique packages
sort /tmp/output_directory/merged_dependencise.csv | uniq > /tmp/output_directory/consolidated_dependencies.csv

# Delete the original .txt files after creating the .csv in /tmp directory
for file in /tmp/output_directory/dependencies*.txt; do
  if [ -f "$file" ]; then
    rm "$file"
  fi
done

# Clean up - Remove merged file and unique_packages.txt in /tmp directory
rm -rf /tmp/output_directory/merged_dependencise.csv

# Consolidate all dependency files into one
#cat /tmp/sas_dependencies*.csv > /tmp/consolidated_dependencies.csv

echo "Consolidated CSV file generated: /tmp/output_directory/consolidated_dependencies.csv"
echo "Consolidated CSV file generated: /tmp/output_directory/unique_packages.csv"
