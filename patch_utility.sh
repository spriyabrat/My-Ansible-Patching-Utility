#!/bin/bash

# Help message
help_message() {
  echo -e "Usage: \033[1m./patch_utility.sh\033[0m [OPTIONS]"
  echo -e "Options:"
  echo -e "  \033[1m--list\033[0m        Display available tags"
  echo -e "  \033[1m--help\033[0m        Display this help message"
  echo -e "  \033[1m--commands\033[0m    Display list of available commands"
  echo
  echo -e "\033[1mTag Usage and Command:\033[0m"
  echo
  echo -e "  \033[1;31mdownload_report\033[0m      - Download server list report"
  echo
  echo -e "    \033[0mDescription:\033[0m This tag is used to download server list with Pro status and Kernel Upgrade status."
  echo
  echo -e "    \033[0mCommand:\033[0m"
  echo -e "      \033[1m./patch_utility.sh tag_name parameters\033[0m"
  echo
  echo -e "    \033[0mParameters:\033[0m"
  echo -e "      \033[0m\"cli_hosts=value\"\033[0m       #The value can either be an IP address or the name of an AWS tag assigned to hosts."
  echo
  echo -e "    \033[0mExamples:\033[0m"
  echo -e "      \033[0,32m[1]\033[0m \033[1m./patch_utility.sh download_report \"cli_hosts=dev\"\033[0m"
  echo
  echo -e "  \033[1;31mview_console\033[0m      - View console"
  echo
  echo -e "    \033[0mDescription:\033[0m This tag is used to view the dashboard where the detailed information of Diffrent Servers will be displayed"
  echo
  echo -e "    \033[0mCommand:\033[0m"
  echo -e "      \033[1m./patch_utility.sh tag_name parameters\033[0m"
  echo
  echo -e "    \033[0mParameters:\033[0m"
  echo -e "      \033[0m\"cli_hosts=value\"\033[0m       #The value can either be an IP address or the name of an AWS tag assigned to hosts."
  echo
  echo -e "    \033[0mExamples:\033[0m"
  echo -e "      \033[1;32m[1]\033[0m \033[1m./patch_utility.sh view_console \"cli_hosts=dev\"\033[0m"
  echo
  echo -e "  \033[1;31mupgrade_kernel\033[0m      - Upgrade the kernel"
  echo
  echo -e "    \033[0mDescription:\033[0m This tag is used to upgrade the kernel to the latest version on the server."
  echo
  echo -e "    \033[0mCommand:\033[0m"
  echo -e "      \033[1m./patch_utility.sh tag_name parameters\033[0m"
  echo
  echo -e "    \033[0mParameters:\033[0m"
  echo -e "      \033[0m\"cli_hosts=value\"\033[0m       #The value can either be an IP address or the name of an AWS tag assigned to hosts."
  echo -e "      \033[0m\"kernel_version=value\"\033[0m  #Specify the kernel version to be patched"
  echo
  echo -e "    \033[0mExamples:\033[0m"
  echo -e "      \033[1;32m[1]\033[0m \033[1m./patch_utility.sh upgrade_kernel \"cli_hosts=dev kernel_version=5.4.0-1110\"\033[0m"
  echo
  echo -e "  \033[1;31mset_cadence\033[0m      - Set Cadence for Canonical Livepatch"
  echo
  echo -e "    \033[0mDescription:\033[0m This tag is used to upgrade the kernel to the latest version on the server."
  echo
  echo -e "    \033[0mCommand:\033[0m"
  echo -e "      \033[1m./patch_utility.sh tag_name parameters\033[0m"
  echo
  echo -e "    \033[0mParameters:\033[0m"
  echo -e "      \033[0m\"cli_hosts=value\"\033[0m            #The value can either be an IP address or the name of an AWS tag assigned to hosts."
  echo -e "      \033[0m\"check_time_interval=value\"\033[0m  #Specify the time interval to set"
  echo
  echo -e "    \033[0mExamples:\033[0m"
  echo -e "      \033[1;32m[1]\033[0m \033[1m./patch_utility.sh set_cadence \"cli_hosts=dev check_time_interval=110\"\033[0m"
  echo
  echo -e "  \033[1;31mapply_security_patch\033[0m      - Apply security patch"
  echo
  echo -e "    \033[0mDescription:\033[0m This tag is used to apply available security patches on the server"
  echo
  echo -e "    \033[0mCommand:\033[0m"
  echo -e "      \033[1m./patch_utility.sh tag_name parameters\033[0m"
  echo
  echo -e "    \033[0mParameters:\033[0m"
  echo -e "      \033[0m\"cli_hosts=value\"\033[0m       #The value can either be an IP address or the name of an AWS tag assigned to hosts."
  echo
  echo -e "    \033[0mExamples:\033[0m"
  echo -e "      \033[1;32m[1]\033[0m \033[1m./patch_utility.sh apply_security_patch \"cli_hosts=dev\"\033[0m"
  echo
  echo -e "  \033[1;31mattach_pro_license\033[0m      - Attach Pro License"
  echo
  echo -e "    \033[0mDescription:\033[0m This tag is used to attach Pro License on the server"
  echo
  echo -e "    \033[0mCommand:\033[0m"
  echo -e "      \033[1m./patch_utility.sh tag_name parameters\033[0m"
  echo
  echo -e "    \033[0mParameters:\033[0m"
  echo -e "      \033[0m\"cli_hosts=value\"\033[0m       #The value can either be an IP address or the name of an AWS tag assigned to hosts."
  echo
  echo -e "    \033[0mExamples:\033[0m"
  echo -e "      \033[1;32m[1]\033[0m \033[1m./patch_utility.sh attach_pro_license \"cli_hosts=dev\"\033[0m"
  echo
  echo -e "  \033[1;31mdetach_pro_license\033[0m      - Detach Pro License"
  echo
  echo -e "    \033[0mDescription:\033[0m This tag is used to detach Pro License from the server"
  echo
  echo -e "    \033[0mCommand:\033[0m"
  echo -e "      \033[1m./patch_utility.sh tag_name parameters\033[0m"
  echo
  echo -e "    \033[0mParameters:\033[0m"
  echo -e "      \033[0m\"cli_hosts=value\"\033[0m       #The value can either be an IP address or the name of an AWS tag assigned to hosts."
  echo
  echo -e "    \033[0mExamples:\033[0m"
  echo -e "      \033[1;32m[1]\033[0m \033[1m./patch_utility.sh detach_pro_license \"cli_hosts=dev\"\033[0m"
  echo
  echo
  echo -e "  \033[1;31munattended_disabled\033[0m - Disable unattended upgrades on specific"
  echo
  echo -e "    \033[0mDescription:\033[0m This tag is used to prevent unattended upgrades on the server and ensure that only the designated task is executed."
  echo
  echo -e "    \033[0mCommand:\033[0m"
  echo -e "      \033[1m./patch_utility.sh unattended_disabled \"cli_hosts=value\"\033[0m"
  echo
  echo -e "    \033[0mParameters:\033[0m"
  echo -e "      \033[0m\"cli_hosts=value\"\033[0m       # The value can either be an IP address or the name of an AWS tag assigned to hosts."
  echo
  echo -e "    \033[0mExamples:\033[0m"
  echo -e "      \033[1;32m[1]\033[0m \033[1m./patch_utility.sh unattended_disabled \"cli_hosts=dev\"\033[0m"
  echo
  echo -e "  \033[1;31mrollback_kernel\033[0m      - Rollback the kernel"
  echo
  echo -e "    \033[0mDescription:\033[0m This tag is used to rollback the kernel to its previous on the server."
  echo
  echo -e "    \033[0mCommand:\033[0m"
  echo -e "      \033[1m./patch_utility.sh tag_name parameters\033[0m"
  echo
  echo -e "    \033[0mParameters:\033[0m"
  echo -e "      \033[0m\"cli_hosts=value\"\033[0m       #The value can either be an IP address or the name of an AWS tag assigned to hosts."
  echo -e "      \033[0m\"kernel_version=value\"\033[0m  #Specify the old kernel version to which kernel should be downgraded"
  echo
  echo -e "    \033[0mExamples:\033[0m"
  echo -e "      \033[1;32m[1]\033[0m \033[1m./patch_utility.sh rollback_kernel \"cli_hosts=dev kernel_version=4.15.0-1050-aws\"\033[0m"
  echo
}

# Function to display available tags
display_tags() {
  echo "Available tags:"
  echo "1. download_report"
  echo "2. view_console"
  echo "3. upgrade_kernel"
  echo "4. set_cadence"
  echo "5. apply_security_patch"
  echo "6. attach_pro_license"
  echo "7. detach_pro_license"
  echo "8. unattended_disabled"
  echo "9. rollback_kernel"
}

# Function to display available commands
display_commands() {
  echo
  echo "Available commands:"
  echo
  echo "./patch_utility.sh --help"
  echo "./patch_utility.sh --list"
  echo "./patch_utility.sh --commands"
  echo "./patch_utility.sh download_report \"cli_hosts=dev\""
  echo "./patch_utility.sh view_console \"cli_hosts=dev\""
  echo "./patch_utility.sh upgrade_kernel \"cli_hosts=dev kernel_version=5.4.0-1110\""
  echo "./patch_utility.sh set_cadence \"cli_hosts=dev check_time_interval=101\""
  echo "./patch_utility.sh apply_security_patch \"cli_hosts=dev\""
  echo "./patch_utility.sh attach_pro_license \"cli_hosts=dev\""
  echo "./patch_utility.sh detach_pro_license \"cli_hosts=dev\""
  echo "./patch_utility.sh unattended_disabled \"cli_hosts=dev\""
  echo "./patch_utility.sh rollback_kernel \"cli_hosts=dev kernel_version=4.15.0-1050-aws\""
  echo
}

# Function to run Ansible playbook based on the provided tag and parameters
run_playbook_by_tag() {
  local tag="$1"
  local parameters="$2"

  case $tag in
    "download_report")
      ansible-playbook -i inventory.yml server_list.yml --tags "$tag" -e "$parameters"
      ;;
    "view_console")
      ./view_console.sh "$tag" "$parameters"
      ;;
    "upgrade_kernel")
      ansible-playbook -i inventory.yml kernel.yml --tags "$tag" -e "$parameters"
      ;;
    "set_cadence")
      ansible-playbook -i inventory.yml cadence.yml --tags "$tag" -e "$parameters"
      ;;
    "apply_security_patch")
      ansible-playbook -i inventory.yml security_patch.yml --tags "$tag" -e "$parameters"
      ;;
    "attach_pro_license")
      ansible-playbook -i inventory.yml pro.yml --tags "$tag" -e "$parameters"
      ;;
    "detach_pro_license")
      ansible-playbook -i inventory.yml pro_detach.yml --tags "$tag" -e "$parameters"
      ;;
    "unattended_disabled")
      ansible-playbook -i inventory.yml kernel.yml --tags "$tag" -e "$parameters"
      ;;
    "rollback_kernel")
      ansible-playbook -i inventory.yml rollback.yml --tags "$tag" -e "$parameters"
      ;;
    *)
      echo "Invalid tag. Please select a valid tag."
      exit 1
      ;;
  esac
}

# Main script

# Check if no arguments are provided
if [ "$#" -eq 0 ]; then
  echo
  echo "Include the necessary tags and parameters by consulting the following:"
  echo
  echo -e "1.Access the help section with the command:       \033[1m./patch_utility.sh --help\033[0m"
  echo -e "2.Find list of commands for specific tasks using: \033[1m./patch_utility.sh --commands\033[0m"
  exit 0
fi

# Check if --help is passed and display help message
if [ "$1" == "--help" ]; then
  help_message
  exit 0
fi

# Check if the --commands option is passed and display commands
if [ "$1" == "--commands" ]; then
  display_commands
  exit 0
fi

# Check if the --list tag is passed and display tags
if [ "$1" == "--list" ]; then
  display_tags
  exit 0
fi

# Check if at least two arguments are provided
if [ "$#" -lt 2 ]; then
  echo "Usage: $0 <tag> <parameters>"
  exit 1
fi

tag="$1"
parameters="${@:2}"

# Display available tags and validate the provided tag
case $tag in
  "download_report" | "view_console" | "upgrade_kernel" | "set_cadence" | "apply_security_patch" | "attach_pro_license" | "detach_pro_license" | "unattended_disabled" | "rollback_kernel")
    echo "Running playbook with tag: $tag and parameters: $parameters"
    run_playbook_by_tag "$tag" "$parameters"
    ;;
  *)
    echo "Invalid tag. Please select a valid tag."
    exit 1
    ;;
esac
