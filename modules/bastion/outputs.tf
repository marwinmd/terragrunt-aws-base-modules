output "security_group_id" {
  description = "The security group ID for usingg in other SGs"
  value       = module.sg_to_bastion.this_security_group_id
}

output "internal_key_name" {
  description = "The name of public key for internal connects"
  value       = var.internal_key_name
}