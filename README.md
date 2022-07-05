## ClusterCreationTool (K3s)
This tool is used to create and bootstrap a three node K3s cluster in AWS EC2.

### Usage
You can clone this repository and work from within the `ClusterCreationTool-K3s` directory.

Refer to the requirements.txt for required dependencies.

You should run `aws-configure` prior to using and replace the public key in the `main.tf` filewith your own. 

1. `bootstrap.sh` is used to create the cluster
	* Ansible playbook execution is pretty flaky; if it fails, just run the playbook `ansible playbook k3s_bootstrap.yaml -i inventory.txt -u ubuntu` 
	* If you have to run the playbook manually, you'll also wanna run the `fix_kube_config.sh` script to fetch the correct cluster config.
2. `teardown.sh` destroys the cluster

After running the boostrap script, you should be able to interact with your cluster via `kubectl`
