#!/usr/bin/bash

# assuming aws configure has been run 

INSTANCES=$(aws ec2 describe-instances --region us-east-2 | jq '.' | grep PublicIpAddress | awk '{print $2}' | cut -d '"' -f 2)

# create ansible inventory file
ctr=0
for i in $INSTANCES
do
	if [[ ctr -eq  0 ]]
	then
		echo $'[Control]\n'$i > ansible/test-inv.ini
	fi
	if [[ ctr -eq  1 ]]
	then
		echo $'[Worker]\n'$i >> ansible/test-inv.ini
	fi
	if [[ ctr -eq  2 ]]
	then
		echo $i >> ansible/test-inv.ini
	fi
	ctr=$ctr+1
done

# display inventory
echo "Listing Ansible inventory file..."
cat ansible/test-inv.ini

# write to /etc/ansible/hosts
INVENTORY_FILE="/etc/ansible/hosts"
rm -rf /etc/ansible/
mkdir /etc/ansible/
sudo touch /etc/ansible/hosts

echo "Writing to /etc/ansible/hosts..."
sudo cp ansible/test-inv.ini /etc/ansible/hosts



