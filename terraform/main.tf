# Terraform Configuration
terraform {
	required_providers {
		aws = {
			source = "hashicorp/aws"
			version: "4.18.0"
		}
	}
}

# Configure a VPC
resource "aws_vpc" "vpc_01" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = {
    Name = "vpc_01"
  }
}


# Configure a subnet for our VPC
resource "aws_subnet" "subnet_01" {
  vpc_id = aws_vpc.vpc_01.id
  cidr_block = "10.0.1.0/24"
  tags = {
    Name = "subnet_01"
  }
}

# Configure an internet gateway
resource "aws_internet_gateway" "gateway_01" {
  vpc_id = "${aws_vpc.vpc_01.id}"
  tags = {
      Name = "gateway_01"
  }
}

# Configuring route tables
resource "aws_route_table" "route_table_01" {
  vpc_id = "${aws_vpc.vpc_01.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gateway_01.id}"
  }
  tags = {
    Name = "route_table_01"
  }
}

resource "aws_route_table_association" "subnet_association" {
  subnet_id = "${aws_subnet.subnet_01.id}"
  route_table_id = "${aws_route_table.route_table_01.id}"
}

# Configure security group
resource "aws_security_group" "ingress-all" {
  name = "allow-all-sg"
  vpc_id = "${aws_vpc.vpc_01.id}"
  ingress {
    cidr_blocks = [
      "0.0.0.0/0"
    ]
    from_port = 22
    to_port = 22
    protocol = "tcp"
  }
  # Terraform removed the default rule
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Configure public key
resource "aws_key_pair" "key_01" {
  key_name = "key_01"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDY9iGZ4ojZFKoh0csRGOzUS3+fFHujXl0dvucRe3jc6Qgv2PbW16piTm+PPLNA/do9EhKqeyLXyxTrRx3LbyrrBJ15PUxdkUQ/k81k/7XWly4c/NwebWhP/VD2OCvPe26bA4zHVw9TI4ugKQD3TvYY1astvOcFkuj+hMsKUIALhrX/+aYmoI+rxqFag4oOJvV84+bgVb7Dli01hOIIpMnpnoXgNPhuFbcvKHUfExRf3Kl/auh+Rcf1YN8+esY8PuFD7u0DSQiM39iarODbQMxesMGS8Uwd4vr41Y6UdHrosIUKc33jvQ0N7nRt7adS3iD4cK56Zqmp4W8Tv71v6EwLyQJfuUmYrtGpoaTqf57GewmwauHF1+5M/Dvu37zAOvvC1OTuzK/FzcTBJ6SJDDKDfUvXg+AaVeIUMsf/rPWYhJhqEgswmOIn2Q69Tx0opps7JGnybo72Fse+jvA/I2XTX1B5OCCdV3eY0wIpK6le12WPcIiIk8sz84KAOlCsues= n1lla@n1lla-HP-EliteBook-840-G5"
}

# Configure AWS Provider
provider "aws" {
	region = "us-east-2"
	profile = "default_01"
}

# Create an EC2 Instance. This is node_01.
resource "aws_instance" "node_01" {
	ami	= "ami-0eea504f45ef7a8f7"
	instance_type = "t3.micro"
  security_groups = ["${aws_security_group.ingress-all.id}"] 
  key_name = "key_01"
	tags = {
		Role = "Master01"
	}
  subnet_id = "${aws_subnet.subnet_01.id}"
}

# Create an EC2 Instance. This is node_02.
resource "aws_instance" "node_02" {
	ami	= "ami-0eea504f45ef7a8f7"
	instance_type = "t3.micro"
  security_groups = ["${aws_security_group.ingress-all.id}"]
  key_name = "key_01"
	tags = {
		Role = "Master02"
	}
  subnet_id = "${aws_subnet.subnet_01.id}"
}

# Create an EC2 Instance. This is node_03.
resource "aws_instance" "node_03" {
	ami	= "ami-0eea504f45ef7a8f7"
	instance_type = "t3.micro"
  security_groups = ["${aws_security_group.ingress-all.id}"]
  key_name = "key_01"
	tags = {
		Role = "Master03"
	}
  subnet_id = "${aws_subnet.subnet_01.id}"
}

# Configure Elastic IPs for our nodes
resource "aws_eip" "ip_01" {
  instance = "${aws_instance.node_01.id}"
  vpc = true
}
resource "aws_eip" "ip_02" {
  instance = "${aws_instance.node_02.id}"
  vpc = true
}
resource "aws_eip" "ip_03" {
  instance = "${aws_instance.node_03.id}"
  vpc = true
}
