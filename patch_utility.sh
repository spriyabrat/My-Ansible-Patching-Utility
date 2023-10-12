#!/bin/bash

# Help message
help_message() {
  echo -e "Usage: \033[1m./patch_utility\033[0m [OPTIONS]"
  echo -e "Options:"
  echo -e "  \033[1m--list\033[0m        Display available tags"
  echo -e "  \033[1m--help\033[0m        Display this help message"
  echo
  echo -e "\033[1mTag Usage and Command:\033[0m"

  echo -e "  \033[1;31mDownload_Report\033[0m     - Fetch server list"
  echo -e "    \033[0mDescription:\033[0m This tag is used to fetch the server list with Pro status and Kernel Upgrade status."
  echo -e "    \033[0mCommand:\033[0m \033[1m./patch_utility [tags] \033[1m'["parameters=value"]\033[0m'"
  echo -e "    \033[0mExample:\033[0m ./patch_utility Download_Report \"kernel_version=5.4.0-1110-aws\""
  echo

  echo -e "  \033[1;31mView_Console\033[0m        - View console"
  echo -e "    \033[0mDescription:\033[0m This tag is used to view the dashboard where the detailed information of Diffrent Servers will be displayed"
  echo -e "    \033[0mCommand:\033[0m \033[1m./patch_utility [tags] \033[0m"
  echo -e "    \033[0mExample:\033[0m ./patch_utility View_Console"
  echo

  echo -e "  \033[1;31mUpgrade_Kernel\033[0m      - Upgrade the kernel"
  echo -e "    \033[0mDescription:\033[0m This tag is used to upgrade the kernel to latest version on the server."
  echo -e "    \033[0mCommand:\033[0m \033[1m./patch_utility [tags] \033[1m'["parameters=value"]\033[0m'"
  echo -e "    \033[0mExample:\033[0m ./patch_utility Upgrade_Kernel \"kernel_version=5.4.0-1110-aws\""
  echo

  echo -e "  \033[1;31mSet_Cadence\033[0m         - Set cadence"
  echo -e "    \033[0mDescription:\033[0m This tag is for changing the check-interval the config file of canonical-livepatch on the server."
  echo -e "    \033[0mCommand:\033[0m \033[1m./patch_utility [tags] \033[1m'["parameters=value"]\033[0m'"
  echo -e "    \033[0mExample:\033[0m ./patch_utility Set_Cadence \"check_time_interval=10m\""
  echo

  echo -e "  \033[1;31mApply_Security_Patch\033[0m - Apply security patch"
  echo -e "    \033[0mDescription:\033[0m This tag is used to apply available security patches on the server."
  echo -e "    \033[0mCommand:\033[0m \033[1m./patch_utility [tags] \033[1m'["parameters=value"]\033[0m'"
  echo -e "    \033[0mExample:\033[0m ./patch_utility Apply_Security_Patch \"host=example.com\""
  echo

  echo -e "  \033[1;31mAttach_Pro_License\033[0m           - Attach Pro License"
  echo -e "    \033[0mDescription:\033[0m This tag is used to attach Pro License on the server."
  echo -e "    \033[0mCommand:\033[0m \033[1m./patch_utility [tags] \033[1m'["parameters=value"]\033[0m'"
  echo -e "    \033[0mExample:\033[0m ./patch_utility Attach_Pro_License \"host=example.com\""
  echo

  echo -e "  \033[1;31mDetach_Pro_License\033[0m           - Detach Pro License"
  echo -e "    \033[0mDescription:\033[0m This tag is used to detach Pro License from the server."
  echo -e "    \033[0mCommand:\033[0m \033[1m./patch_utility [tags] \033[1m'["parameters=value"]\033[0m'"
  echo -e "    \033[0mExample:\033[0m ./patch_utility Detach_Pro_License \"host=example.com\""
  echo

  echo -e "  \033[1;31mRollback_Kernel\033[0m      - Rollback the kernel"
  echo -e "    \033[0mDescription:\033[0m This tag is used to rollback the kernel to its previous on the server."
  echo -e "    \033[0mCommand:\033[0m \033[1m./patch_utility [tags] \033[1m'["parameters=value"]\033[0m'"
  echo -e "    \033[0mExample:\033[0m ./patch_utility Rollback_Kernel \"host=example.com\""
}

# Function to display available tags
display_tags() {
  echo "Available tags:"
  echo "1. Download_Report"
  echo "2. View_Console"
  echo "3. Upgrade_Kernel"
  echo "4. Set_Cadence"
  echo "5. Apply_Security_Patch"
  echo "6. Attach_Pro_License"
  echo "7. Detach_Pro_License"
  echo "8. Rollback_Kernel"
}

# Function to run Ansible playbook based on the provided tag and parameters
run_playbook_by_tag() {
  local tag="$1"
  local parameters="$2"

  case $tag in
    "Download_Report")
      ansible-playbook -i inventory.yml fetch_server_list.yml --tags "$tag" -e "$parameters"
      ;;
    "view_console")
      ansible-playbook -i inventory.yml view_console.yml --tags "$tag" -e "$parameters"
      ;;
    "upgrade_kernel")
      ansible-playbook -i inventory.yml kernel.yml --tags "$tag" -e "$parameters"
      ;;
    "Set_Cadence")
      ansible-playbook -i inventory.yml cadence.yml --tags "$tag" -e "$parameters"
      ;;
    "apply_security_patch")
      ansible-playbook -i inventory.yml security_patch.yml --tags "$tag" -e "$parameters"
      ;;
    "attach_pro")
      ansible-playbook -i inventory.yml pro.yml --tags "$tag" -e "$parameters"
      ;;
    "detach_pro")
      ansible-playbook -i inventory.yml pro_detach.yml --tags "$tag" -e "$parameters"
      ;;
    "kernel_rollback")
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
  echo "Put Required tags and Parameters"
  echo -e "Refer to the help section using: \033[1m./patch_utility --help\033[0m"
  exit 0
fi

# Check if --help is passed and display help message
if [ "$1" == "--help" ]; then
  help_message
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
  "Download_Report" | "view_console" | "upgrade_kernel" | "Set_Cadence" | "apply_security_patch" | "attach_pro" | "detach_pro" | "kernel_rollback")
    echo "Running playbook with tag: $tag and parameters: $parameters"
    run_playbook_by_tag "$tag" "$parameters"
    ;;
  *)
    echo "Invalid tag. Please select a valid tag."
    exit 1
    ;;
esac
