
terraform {
  backend "s3" {}
}

provider "aws" {
  version = "~> 2.18"
  region  = var.aws_region
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = var.name
  cidr = var.cidr

  azs              = var.azs
  private_subnets  = var.private_subnets
  public_subnets   = var.public_subnets
  database_subnets = var.database_subnets
  intra_subnets    = var.intra_subnets

  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support
  enable_nat_gateway   = var.enable_nat_gateway
  single_nat_gateway   = var.single_nat_gateway
  
  enable_vpn_gateway   = var.enable_vpn_gateway
  enable_s3_endpoint   = var.enable_s3_endpoint

  enable_ssm_endpoint                      = var.enable_ssm_endpoint
  ssm_endpoint_security_group_ids          = [module.sg_for_ssm.this_security_group_id]
  ssm_endpoint_private_dns_enabled         = var.enable_ssm_endpoint
  enable_ssmmessages_endpoint              = var.enable_ssm_endpoint
  ssmmessages_endpoint_security_group_ids  = [module.sg_for_ssm.this_security_group_id]
  ssmmessages_endpoint_private_dns_enabled = var.enable_ssm_endpoint

  enable_dhcp_options      = var.enable_dhcp_options
  dhcp_options_domain_name = var.private_domain

  tags = {
    Terraform   = "true"
    environment = var.environment
    project     = var.aws_project
  }
}

resource "aws_route53_zone" "private" {
  name = var.private_domain

  vpc {
    vpc_id = module.vpc.vpc_id
  }
}

module "sg_for_ssm" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 3.0"

  name        = "sg_for ssm"
  description = "SG for access from AWS SSM"
  vpc_id      = module.vpc.vpc_id

  egress_rules = ["all-all"]

  ingress_with_cidr_blocks = [
    {
      rule        = "https-443-tcp"
      cidr_blocks = var.cidr
    },
    {
      rule        = "all-icmp"
      cidr_blocks = var.cidr
      description = "Ping from VPC"
    }
  ]
  tags = {
    Terraform   = "true"
    environment = var.environment
    project     = var.aws_project
  }
}