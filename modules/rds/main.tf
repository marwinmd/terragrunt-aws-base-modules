module "rds" {
  source  = "terraform-aws-modules/rds/aws"
  version = "~> 2.15.0"

  name = var.name
  identifier = var.identifier

  username = var.username
  password = var.password
  port     = var.port

  engine            = var.engine
  engine_version    = var.engine_version
  family = var.family
  major_engine_version = var.major_engine_version
  instance_class    = var.instance_class
  allocated_storage = var.allocated_storage
  max_allocated_storage = var.max_allocated_storage
  storage_encrypted = var.storage_encrypted

  kms_key_id = var.kms_key_id

   vpc_security_group_ids = var.vpc_security_group_ids

  maintenance_window = var.maintenance_window
  backup_window      = var.backup_window
  backup_retention_period = var.backup_retention_period
  final_snapshot_identifier = var.final_snapshot_identifier
  snapshot_identifier = var.snapshot_identifier

  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports

  subnet_ids = var.subnet_ids

  deletion_protection = var.deletion_protection

  tags = "${merge(local.common_tags, local.backup_tags, var.custom_tags)}"
}

locals {
  common_tags = {
    Terraform   = "true"
    environment = var.environment
    project     = var.aws_project
  }

  backup_tags = {
    "shelvery:create_backup" = var.shelvery_backup
  }
}


resource "aws_route53_record" "rds" {
  count   = var.route53_zone_id == "" ? 0 : 1
  zone_id = var.route53_zone_id
  name    = "${var.identifier}-rds"
  type    = "CNAME"
  ttl     = "60"
  records = [module.rds.this_db_instance_address]
}