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
  description = "The name of the Launch Configuration"
  type        = string
}

#variable "target_os" {
#  description = "The default AMI for target. Values: CentOS7"
#  type        = string
#  default     = "CentOS7"
#}

variable "image_id" {
  description = "The AMI for the Instance. Default is latest CentOS7"
  type        = string
  default     = null
}

variable "root_disk_size" {
  description = "Size of 1st Device"
  type        = number
  default     = 10
}

variable "target_disk_size" {
  description = "Size of Destination Device"
  type        = number
  default     = 12
}

variable "instance_type" {
  type    = string
  default = "t2.small"
}

variable "cpu_credits" {
  description = "The credit option for CPU usage (unlimited or standard)"
  type        = string
  default     = "standard"
}

variable "instance_profile" {
  type    = string
  default = ""
}

variable "key_name" {
  type    = string
  default = ""
}