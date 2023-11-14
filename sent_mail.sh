#!/bin/bash
#Purpose of This script is run a playbook which will be create a report and sent mail,which can be later used in cronjob
#crontab -l
#Ansible: update palantir repo
#*/10 * * * * cd /srv/jenkins/palantir && /usr/bin/git pull

#send daily report for os-patching related activity at 10.30 am IST
#0 5 * * * /bin/bash $HOME/palantir/ansible2/adhoc_playbooks/send_mail.sh > /tmp/ansible_os-patching.log 2>&1

/usr/local/bin/ansible-playbook2 $HOME/palantir/ansible2/adhoc_playbooks/server_report.yml -e 'cli_hosts=all cli_region=us-east-1' --vault-password-file ~/.vault -D
