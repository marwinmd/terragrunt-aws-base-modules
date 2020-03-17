data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "public" {
  vpc_id = data.aws_vpc.default.id
}

data "aws_subnet" "selected" {
  id = tolist(data.aws_subnet_ids.public.ids)[0]
}

data "aws_security_groups" "default" {
  filter {
    name   = "group-name"
    values = ["default"]
  }

  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

# aws ec2 describe-images --region eu-central-1 --image-ids ami-04cf43aca3e6f3de3
data "aws_ami" "centos7" {
  owners      = ["679593333241"]
  most_recent = true

  filter {
    name   = "name"
    values = ["CentOS Linux 7 x86_64 HVM EBS ENA 1901_01-b7ee8a69-ee97-4a49-9e68-afaee216db2e-*"]
  }

  filter {
    name   = "owner-id"
    values = ["679593333241"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "state"
    values = ["available"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}

resource "aws_launch_template" "amigen7" {
  name = var.name

  block_device_mappings {
    device_name = "/dev/sda1"

    ebs {
      volume_size           = var.root_disk_size
      volume_type           = "standard"
      delete_on_termination = true
      encrypted             = true
    }
  }

  block_device_mappings {
    device_name = "/dev/sdb"

    ebs {
      volume_size           = var.target_disk_size
      volume_type           = "standard"
      delete_on_termination = true
    }
  }

  credit_specification {
    cpu_credits = "standard"
  }

  iam_instance_profile {
    name = var.instance_profile
  }

  image_id      = var.image_id == null ? data.aws_ami.centos7.id : var.image_id
  instance_type = var.instance_type
  key_name      = var.key_name

  network_interfaces {
    subnet_id                   = data.aws_subnet.selected.id
    security_groups             = data.aws_security_groups.default.ids
    associate_public_ip_address = true
    delete_on_termination       = true
  }

  placement {
    availability_zone = data.aws_subnet.selected.availability_zone
  }

  user_data = filebase64("${path.module}/user_data.sh")

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name        = var.name
      Terraform   = "true"
      environment = var.environment
      project     = var.aws_project
    }
  }
}