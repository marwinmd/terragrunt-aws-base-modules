
terraform {
  backend "s3" {}
}

provider "aws" {
  version = "~> 2.18"
  region  = var.aws_region
}

resource "aws_iam_role_policy" "dlm_lifecycle" {
  name = "${var.dlm_policy}_dlm-lifecycle-policy"
  role = aws_iam_role.dlm_lifecycle_role.id

  policy = <<EOF
{
   "Version": "2012-10-17",
   "Statement": [
      {
         "Effect": "Allow",
         "Action": [
            "ec2:CreateSnapshot",
            "ec2:DeleteSnapshot",
            "ec2:DescribeVolumes",
            "ec2:DescribeSnapshots"
         ],
         "Resource": "*"
      },
      {
         "Effect": "Allow",
         "Action": [
            "ec2:CreateTags"
         ],
         "Resource": "arn:aws:ec2:*::snapshot/*"
      }
   ]
}
EOF
}

resource "aws_iam_role" "dlm_lifecycle_role" {
  name = "${var.dlm_policy}_dlm-lifecycle-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "dlm.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_dlm_lifecycle_policy" "dlm-policy" {
  description        = var.dlm_policy
  execution_role_arn = aws_iam_role.dlm_lifecycle_role.arn
  state              = "ENABLED"
  policy_details {
    resource_types = ["VOLUME"]
    schedule {
      name = var.snapshot_name
      create_rule {
        interval      = var.interval_hours
        interval_unit = "HOURS"
        times         = [var.start_time]
      }
      retain_rule {
        count = var.retention_count
      }
      tags_to_add = {
        SnapshotCreator = "DLM"
      }
      copy_tags = var.copy_tags
    }

    target_tags = {
      dlm_snapshot = "true"
      dlm_policy   = var.dlm_policy
    }
  }
}