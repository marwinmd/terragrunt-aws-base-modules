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

variable "name" {
  description = "name of the VPC"
  type        = string
}

variable "private_domain" {
  description = "domain of private route53 on VPC"
  type        = string
  default     = "local"
}

variable "manage_default_vpc" {
  description = "Should be true to adopt and manage Default VPC"
  type        = bool
  default     = false
}

variable "cidr" {
  description = "CIDR of the VPC"
  type        = string
}

variable "azs" {
  description = "AZs of the VPC"
  type        = list(string)
}

variable "private_subnets" {
  description = "private_subnets of the VPC"
  type        = list(string)
  default     = []
}

variable "public_subnets" {
  description = "public_subnets of the VPC"
  type        = list(string)
  default     = []
}

variable "intra_subnets" {
  description = "intra_subnets of the VPC"
  type        = list(string)
  default     = []
}

variable "database_subnets" {
  description = "database_subnets of the VPC"
  type        = list(string)
  default     = []
}

variable "enable_dns_hostnames" {
  description = "enable_dns_hostnames of the VPC"
  type        = bool
  default     = true
}

variable "enable_dns_support" {
  description = "enable_dns_support of the VPC"
  type        = bool
  default     = true
}

variable "enable_nat_gateway" {
  description = "enable_nat_gateway of the VPC"
  type        = bool
  default     = false
}

variable "enable_vpn_gateway" {
  description = "enable_vpn_gateway of the VPC"
  type        = bool
  default     = false
}

variable "enable_s3_endpoint" {
  description = "enable_s3_endpoint of the VPC"
  type        = bool
  default     = true
}

variable "enable_ssm_endpoint" {
  description = "enable_ssm_endpoint of the VPC"
  type        = bool
  default     = false
}

# variable "ssm_endpoint_security_group_ids" {
#   description = "ssm_endpoint_security_group_ids of the VPC"
#   type        = bool
#   default = false
# }

variable "enable_dhcp_options" {
  description = "enable_dhcp_options of the VPC"
  type        = bool
  default     = true
}

variable "ssmmessages_endpoint_private_dns_enabled" {
  description = "ssmmessages_endpoint_private_dns_enabled of the VPC"
  type        = bool
  default     = false
}

variable "http_proxy" {
  description = "ssmmessages_endhttp_proxy of the VPC"
  type        = string
  default     = ""
}

variable "single_nat_gateway" {
  description = "Should be true if you want to provision a single shared NAT Gateway across all of your private networks"
  type        = bool
  default     = false
}