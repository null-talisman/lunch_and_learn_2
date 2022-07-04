#!/usr/bin/bash

WORKING_DIR=$(pwd)
TERRAFORM_DIR="terraform"

# terraform
# TODO: check if ec2 instances already exist(?)
cd $TERRAFORM_DIR
terraform apply -auto-approve

# get ec2 instances and run playbook
cd ..
./scripts/get_instances.sh
ansible-playbook ansible/k3s_bootstrap.yaml -i ansible/inventory.txt -u ubuntu

# fix kubeconfig and set as KUBECONFIG
./scripts/fix_kube_config.sh
export KUBECONFIG=kube_fix.yaml

