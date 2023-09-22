## AWS OpenVpn Module Readme
This repository contains a collection of Terraform modules designed to streamline the process of provisioning and managing various AWS resources. These modules are intended to be reusable building blocks, allowing for quick and efficient deployment of infrastructure components.

## Modules Overview

+ Security Group Module:
  Creates a security group with customizable rules and limits.

+ OpenVPN Module:
 Sets up an EC2 instance with OpenVPN pre-installed, ready for secure network access. suing the output of sg module for as security group id .

## Usage
+ Ensure you have the necessary AWS credentials and Terraform installed on your system.
+ Run the following commands in the directory containing your Terraform files:
```hcl
terraform init
terraform apply -var-file=config.tfvars
```
+ Terraform will create AWS Backup policies and associated backup vaults based on the configuration in config.tfvars.