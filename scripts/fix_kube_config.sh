#!/usr/bin/bash

# get control plane ip
CONTROL_PLANE_IP=$(cat ansible/inventory.txt | head -2 | tail -1)
# replace server ip in kube config with correct ip
sed "s/127.0.0.1/$CONTROL_PLANE_IP/g" kube_config.yaml > kube_fix.yaml

