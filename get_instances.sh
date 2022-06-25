#!/usr/bin/bash

# assuming aws configure has been run 

INSTANCES=$(aws ec2 describe-instances | jq '.' | grep PublicIpAddress | awk '{print $2}' | cut -d '"' -f 2)

# create ansible inventory file
ctr=0
for i in $INSTANCES
do
	if [[ ctr -eq  0 ]]
	then
		echo $'[Control]\n'$i > ansible/test-inv.ini
	else
		echo $'[Worker]\n'$i >> ansible/test-inv.ini
	fi
	ctr=$ctr+1
done

# display inventory
echo "Listing Ansible inventory file..."
cat ansible/test-inv.ini


