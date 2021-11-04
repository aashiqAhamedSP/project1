#!/bin/bash
loclip=$(az vm show -d -g jenkin-rg -n vm-build --query privateIps -o tsv)
echo "[localhost]" > /etc/ansible/hosts
echo "$loclip ansible_connection=local" >> /etc/ansible/hosts
docip=$(az vm show -d -g jenkin-rg -n docvm --query privateIps -o tsv)
echo "[remotehost]" >> /etc/ansible/hosts
echo "$docip ansible_connection=ssh" >> /etc/ansible/hosts
rm /home/vmadmin/.ssh/known_hosts
ssh -o "StrictHostKeyChecking no" vmadmin@$docip -i /home/vmadmin/.ssh/authorized_keys/id_rsa
