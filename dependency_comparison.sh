#!/bin/bash
# Create associative arrays to store package dependencies for each release.
declare -A Dependency_18_04
declare -A Dependency_22_04
# Read the 18.04_dep.csv file and update dependencies for 14.04.
while IFS=, read -r package dependencies; do
 if [ -n "$package" ]; then
  Dependency_18_04["$package"]="$dependencies"
 fi
done < dependency_18.csv
# Read the 22.04_dep.csv file and update dependencies for 18.04.
while IFS=, read -r package dependencies; do
 if [ -n "$package" ]; then
  Dependency_22_04["$package"]="$dependencies"
 fi
done < dep_af_22.csv
# Create a CSV file to store the results.
echo "Package,18.04 Dependencies,22.04 Dependencies" > result_depp.csv
# Combine all package names from both releases and sort them alphabetically.
all_packages=($(echo "${!Dependency_18_04[@]}" "${!Dependency_22_04[@]}" | tr ' ' '\n' | sort -u))
# Print the results in CSV format.
for package in "${all_packages[@]}"; do
 dep_18_04="${Dependency_18_04[$package]:-NA}"
 dep_22_04="${Dependency_22_04[$package]:-NA}"
 echo "$package,$dep_18_04,$dep_22_04" >> result_depp.csv
done
echo "Results saved in result_depp.csv."
