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

variable "interval_hours" {
  description = "interval_hours of the DLM"
  type        = string
  default     = "24"
}

variable "snapshot_name" {
  description = "snapshot_name of the DLM"
  type        = string
  default     = "snapshot"
}

variable "start_time" {
  description = "start_time of the DLM"
  type        = string
  default     = "00:30"
}

variable "retention_count" {
  description = "start_time of the DLM"
  type        = string
  default     = "14"
}

variable "copy_tags" {
  description = "copy_tags from volumes"
  type        = bool
  default     = true
}

variable "dlm_policy" {
  description = "dlm_policy Name"
  type        = string
}