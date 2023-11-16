#!/bin/bash
# This script create a comparison of list of packages in between 18.04 and 22.04 machines and create a sheet
# Create associative arrays to store package versions for each release.
declare -A versions_18_04
declare -A versions_22_04

# Read the installed_packages_18.04_172.16.2.120.txt file and update versions for 18.04.
while read -r line; do
 package=$(echo "$line" | awk '{print $1}')
 version=$(echo "$line" | awk '{print $2}')
 if [ -n "$package" ] && [ -n "$version" ]; then
   versions_18_04[$package]="$version"
 fi
done < dependency_18.csv
# Read the 22.txt file and update versions for 22.04.
while read -r line; do
 package=$(echo "$line" | awk '{print $1}')
 version=$(echo "$line" | awk '{print $2}')
 if [ -n "$package" ] && [ -n "$version" ]; then
   versions_22_04[$package]="$version"
 fi
done < dep_af_22.csv
# Create a CSV file to store the results.
echo "Package,18.04 Version,22.04 Version" > result_dep.csv
# Combine all package names and sort them alphabetically.
all_packages=($(echo "${!versions_18_04[@]}" "${!versions_22_04[@]}" | tr ' ' '\n' | sort -u))
# Print the results in CSV format.
for package in "${all_packages[@]}"; do
 echo "$package,${versions_18_04[$package]:-NA},${versions_22_04[$package]:-NA}" >> result_dep.csv
done
echo "Results saved in result_dep.csv"
