terraform {
  backend "s3" {
  }
}

provider "aws" {
  version = "~> 2.18"
  region  = var.aws_region
}

data "aws_caller_identity" "iam" {}

resource "aws_iam_instance_profile" "instance_profile" {
  name = "${var.aws_project}_${var.environment}_SSM"
  role = aws_iam_role.SSMRoleForInstances.name
}

resource "aws_iam_role_policy_attachment" "policy-attach" {
  role       = aws_iam_role.SSMRoleForInstances.name
  policy_arn = aws_iam_policy.SSMManagedInstanceCore.arn
}

resource "aws_iam_role" "SSMRoleForInstances" {
  name               = "${var.aws_project}_${var.environment}_SSMRoleForInstances"
  description        = "EC2 role for SSM"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF

  tags = {
    Terraform   = "true"
    environment = var.environment
    project     = var.aws_project
  }
}


resource "aws_iam_policy" "SSMManagedInstanceCore" {
  name        = "${var.aws_project}_${var.environment}_SSMManagedInstanceCore"
  path        = "/"
  description = "AmazonSSMManagedInstanceCore for ${var.aws_project}"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ssm:DescribeAssociation",
                "ssm:GetDeployablePatchSnapshotForInstance",
                "ssm:GetDocument",
                "ssm:DescribeDocument",
                "ssm:GetManifest",
                "ssm:GetParameter",
                "ssm:GetParameters",
                "ssm:ListAssociations",
                "ssm:ListInstanceAssociations",
                "ssm:PutInventory",
                "ssm:PutComplianceItems",
                "ssm:PutConfigurePackageResult",
                "ssm:UpdateAssociationStatus",
                "ssm:UpdateInstanceAssociationStatus",
                "ssm:UpdateInstanceInformation"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "ssmmessages:CreateControlChannel",
                "ssmmessages:CreateDataChannel",
                "ssmmessages:OpenControlChannel",
                "ssmmessages:OpenDataChannel"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "ec2messages:AcknowledgeMessage",
                "ec2messages:DeleteMessage",
                "ec2messages:FailMessage",
                "ec2messages:GetEndpoint",
                "ec2messages:GetMessages",
                "ec2messages:SendReply"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}