variable "aws_region" {
  description = "The AWS region to deploy to (e.g. us-east-1)"
  type        = string
}

variable "environment" {
  description = "The name of the environment"
  type        = string
}

variable "aws_project" {
  description = "The name of the Project"
  type        = string
}

variable "vpc_id" {
  description = "CIDvpc_idR of the VPC"
  type        = string
}

variable "cidr_block" {
  description = "CIDR of the VPC"
  type        = string
}

variable "subnet_id" {
  type        = string
  description = "subnet_id of Bastion"
  default     = ""
}

variable "iam_instance_profile" {
  default = ""
}

variable "ami_id" {
  description = "Use ami_id instead of searching the AMI2 from Amazon"
  type        = string
  default     = null
}

variable "host_name" {
  type    = string
  default = ""
}

variable "domain_name" {
  type    = string
  default = ""
}

variable "instance_type" {
  default = "t3.nano"
}

variable "cpu_credits" {
  description = "cpu_credits for t3. standard or unlimited"
  default = "unlimited"
}

variable "key_name" {
  default = ""
}

variable "ssh_public_ingress" {
  type        = string
  description = "who is allowed to connect via ssh"
  default     = "169.254.254.254/32"
}

variable "private_ips" {
  type        = list(string)
  description = "Private IPs of Bastion"
  default     = [""]
}

variable "create_internal_key" {
  type        = bool
  description = "create ssh-keys on Bastion for internal connects. This is higly risky. Only useable for plygrounds!"
  default     = false
}

variable "internal_key_name" {
  type        = string
  description = "internal ssh public key"
  default     = ""
}

variable "create_tinyproxy" {
  type        = bool
  description = "Install Tinyproxy on Bastion"
  default     = false
}

variable "route53_zone_id" {
  description = "zone_id for CNAME in route53"
  type        = string
}

variable "public_zone_id" {
  description = "zone_id for public_fqdn route53"
  type        = string
  default     = null
}

variable "dlm_policy" {
  description = "dlm_policy Name"
  type        = string
  default     = null
}