#!/bin/bash
# Create associative arrays to store package versions for each release.
declare -A versions_14_04
declare -A versions_18_04
declare -A versions_22_04
# Read the 14.txt file and update versions for 14.04.
while read -r line; do
 package=$(echo "$line" | awk '{print $2}')
 version=$(echo "$line" | awk '{print $3}')
 if [ -n "$package" ] && [ -n "$version" ]; then
   versions_14_04[$package]="$version"
 fi
done < installed_packages_14.04_172.16.43.47.txt
# Read the installed_packages_18.04_172.16.2.120.txt file and update versions for 18.04.
while read -r line; do
 package=$(echo "$line" | awk '{print $2}')
 version=$(echo "$line" | awk '{print $3}')
 if [ -n "$package" ] && [ -n "$version" ]; then
   versions_18_04[$package]="$version"
 fi
done < installed_packages_18.04_172.16.2.120.txt
# Read the 22.txt file and update versions for 22.04.
while read -r line; do
 package=$(echo "$line" | awk '{print $2}')
 version=$(echo "$line" | awk '{print $3}')
 if [ -n "$package" ] && [ -n "$version" ]; then
   versions_22_04[$package]="$version"
 fi
done < installed_packages_22.04_172.16.11.145.txt
# Create a CSV file to store the results.
echo "Package,14.04 Version,18.04 Version,22.04 Version" > result.csv
# Combine all package names and sort them alphabetically.
all_packages=($(echo "${!versions_14_04[@]}" "${!versions_18_04[@]}" "${!versions_22_04[@]}" | tr ' ' '\n' | sort -u))
# Print the results in CSV format.
for package in "${all_packages[@]}"; do
 echo "$package,${versions_14_04[$package]:-NA},${versions_18_04[$package]:-NA},${versions_22_04[$package]:-NA}" >> result.csv
done
echo "Results saved in result.csv."
