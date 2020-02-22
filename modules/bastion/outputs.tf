# output "from_security_group_id" {
#   description = "The ID of the VPC"
#   value       = module.sg_from_bastion.this_security_group_id
# }

output "internal_key_name" {
  description = "The name of public key for internal connects"
  value       = var.internal_key_name
}