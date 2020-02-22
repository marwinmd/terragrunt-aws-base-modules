variable "aws_region" {
  description = "The AWS region to deploy to (e.g. us-east-1)"
  type        = string
  default     = "eu-central-1"
}

variable "aws_project" {
  description = "The name of the Project"
  type        = string
}

variable "environment" {
  description = "The Environment from Terragrunt"
  type        = string
}