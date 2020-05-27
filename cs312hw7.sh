#!/bin/bash

if [ -e ~/.ssh/id_rsa.pub ]
then
	echo -e "\e[1;36mFile already exists. Skipping ssh key generation.\e[0m"
	echo
	echo
	sleep 3
else
	echo -e "\e[1;32mGenerating ssh key...\e[0m"
	ssh-keygen -t rsa 
	$not_my_first_time=1
fi

echo -e "\e[1;32mCopying each ssh key to the Alpine VMs\e[0m"
ssh-copy-id root@192.168.1.20
ssh-copy-id root@192.168.1.21
ssh-copy-id root@192.168.1.22
ssh-copy-id root@192.168.1.23

echo -e "\e[1;32mConfiguring Ansible Playbook\e[0m"
ansible-playbook webserver.yaml -i hosts.ini

echo -e "\e[1;32mCurly Browsing...\e[0m"
curl 192.168.1.20
sleep 3
curl 192.168.1.21
sleep 3
curl 192.168.1.22
sleep 3
curl 192.168.1.23
