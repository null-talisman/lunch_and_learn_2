## ClusterCreationTool (K3s)
This tool is used to create and bootstrap a three node K3s cluster in AWS EC2.

### Usage
You can clone this repository and work from within the `ClusterCreationTool-K3s` directory.

Refer to the requirements.txt for required dependencies.

You should run `aws configure` prior to using and replace the public key in the `main.tf` filewith your own. Also run `terraform init` in the `terraform` directory prior to using.

1. `bootstrap.sh` is used to create the cluster
	* Ansible playbook execution is pretty flaky; if it fails, just run the playbook `ansible-playbook k3s_bootstrap.yaml -i inventory.txt -u ubuntu` 
	* If you have to run the playbook manually, you'll also wanna run the `fix_kube_config.sh` script to fetch the correct cluster config. The correct config is now in the `kube_config.yaml` file.
2. `teardown.sh` destroys the cluster

After running the boostrap script, you should be able to interact with your cluster via `kubectl`

If you experience a certificate issue, append `--insecure-skip-tls-verify` to the end of your `kubectl` command.

### Dependencies
These apps are needed to support this workflow. The versions are simply the latest available when I installed them.
- ansible 2.13.1
- python 3.10.4
- terraform 1.2.2
- aws-cli 3.9.11
- kubectl 1.24.2

