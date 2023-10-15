#!/bin/bash

format_text_to_table() {
    local input_text=$1
    
    # Split the input text based on '|' and strip whitespace
    IFS='|' read -ra data <<< "$input_text"
    
    # Extract values for each column
    ip=${data[0]}; version=${data[1]}; kernel_version=${data[2]}
    pro_status=${data[3]}; kernel_status=${data[4]}; kernel_version_time=${data[5]}
    unatt_status=${data[6]}; cadence_time=${data[7]}; latest_kernel=${data[8]}
    
    # Create the formatted table with headers
    formatted_table="  IP   | Version | Kernel Version   | Pro Status | Kernel Status | Kernel Version Time | Unatt Status | Cadence Time | Latest Available Kernel\n"
    formatted_table+="----------------------------------------------------------------------------------------------------------------------------------------\n"
    formatted_table+="$ip | $version | $kernel_version | $pro_status | $kernel_status | $kernel_version_time | $unatt_status | $cadence_time | $latest_kernel"
    
    echo -e "$formatted_table"
}

# Read the content from the text file
input_file="new_kernel.txt"
if [ ! -f "$input_file" ]; then
    echo "Input file not found: $input_file"
    exit 1
fi

file_content=$(<"$input_file")

# Format the content and print the table
formatted_table=$(format_text_to_table "$file_content")
echo -e "$formatted_table"
