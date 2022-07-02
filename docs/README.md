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
	* Configure three EC2 instances
		* Networking, Security groups, Key pair.
		* Configuration allows us to SSH to each node as the `Ubuntu` user.
	* Refer to `terraform/main.tf`
- Configure a three node k3s cluster
	* node_01: curl -sfL https://get.k3s.io | sh -
	* node_02: curl -sfL https://get.k3s.io | K3S_URL=https://arden:6443 K3S_TOKEN=K10517f6339ab943fecaabff3553a51a996028e38123aace6b6afd10374d600dee4::server:8dceebabece35fb654f67d92264e3362 sh -
	* node_03: curl -sfL https://get.k3s.io | K3S_URL=https://arden:6443 K3S_TOKEN=K10517f6339ab943fecaabff3553a51a996028e38123aace6b6afd10374d600dee4::server:8dceebabece35fb654f67d92264e3362 sh -
	* K3S_TOKEN: K10517f6339ab943fecaabff3553a51a996028e38123aace6b6afd10374d600dee4::server:8dceebabece35fb654f67d92264e3362

