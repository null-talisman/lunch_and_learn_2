#!/usr/bin/bash

# assuming aws configure has been run 

INSTANCES=$(aws ec2 describe-instances --region us-east-2 | jq '.' | grep PublicIpAddress | awk '{print $2}' | cut -d '"' -f 2)

# create ansible inventory file
ctr=0
for i in $INSTANCES
do
	if [[ ctr -eq  0 ]]
	then
		echo $'[Control]\n'$i > ../ansible/inventory.txt
	fi
	if [[ ctr -eq  1 ]]
	then
		echo $'[Worker]\n'$i >> ../ansible/inventory.txt
	fi
	if [[ ctr -eq  2 ]]
	then
		echo $i >> ../ansible/inventory.txt
	fi
	ctr=$ctr+1
done
