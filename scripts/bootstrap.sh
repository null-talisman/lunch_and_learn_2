#!/usr/bin/bash

# may be useful in future
TERRAFORM_DIR="terraform"

# terraform
# TODO: check if ec2 instances already exist(?)
cd $TERRAFORM_DIR
terraform apply -auto-approve

# get ec2 instances
../scripts/get_instances.sh

# ansible
ansible-playbook ../ansible/k3s_bootstrap.yaml -i ../ansible/inventory.txt
