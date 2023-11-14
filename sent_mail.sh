#!/bin/bash
#Purpose of This script is run a playbook which will be create a report and sent mail,which can be later used in cronjob

/usr/local/bin/ansible-playbook2 $HOME/palantir/ansible2/adhoc_playbooks/server_report.yml -e 'cli_hosts=all cli_region=us-east-1' --vault-password-file ~/.vault -D
