locals {
  protected_instances = {
    for name, config in var.instances :
    name => config if name == "critical-db"
  }
  regular_instances = {
    for name, config in var.instances :
    name => config if name != "critical-db"
  }
}

resource "aws_instance" "protected" {
  for_each = local.protected_instances

  ami                    = var.ami_id
  instance_type          = each.value.instance_type
  key_name               = each.value.key_name
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.security_group_ids

  root_block_device {
    volume_type = each.value.volume_type
    volume_size = each.value.volume_size
    iops        = each.value.iops
    encrypted   = true
  }

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }

  tags = {
    Name        = each.key
    Environment = var.environment
    Owner       = var.owner
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_instance" "regular" {
  for_each = local.regular_instances

  ami                    = var.ami_id
  instance_type          = each.value.instance_type
  key_name               = each.value.key_name
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.security_group_ids

  root_block_device {
    volume_type = each.value.volume_type
    volume_size = each.value.volume_size
    iops        = each.value.iops
    encrypted   = true
  }

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }

  tags = {
    Name        = each.key
    Environment = var.environment
    Owner       = var.owner
  }
}
