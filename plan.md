## Lunch & Learn Project

- Deploy a K8s cluster in AWS using Terraform
- GitOps with Flux for configuration management
- Microservices, Go, Monitoring & Alerting
- Robusta, Flagger, Istio ? 

### 1. Deploying the cluster in AWS
- Use EC2, Amazon's computer platform, to deploy 3 Linux-based VMs. 
	* Install Terraform, AWS CLI
		* (Terraform in 100 Seconds)[https://www.youtube.com/watch?v=tomUWcQ0P3k]
		* (Terraform AWS Provider)[https://registry.terraform.io/providers/hashicorp/aws/latest/docs]
	* Ubuntu 20.04 Server AMI: `ami-0eea504f45ef7a8f7`
	* Create your aws provider configuration file
- Write some terraform to deploy three Ubuntu 20.04 VMs through AWS EC2
	* Refer to `terraform/main.tf`
- Follow K3s documentation to install K3s server on node 1, and join the other two nodes to the cluster.
	* Grab K8s configuration file on the K3s server node (/etc/rancher/k3s/k3s.yaml)
	* Copy this K8s configuration to your ~/.kube/config file on a remote node to interact with the cluster
	* Label the additional two nodes with the worker label: `kubectl label node <NODE> node-role.kubernetes.io/worker=worker`

