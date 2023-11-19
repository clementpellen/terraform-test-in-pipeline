# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

provider "aws" {
  region = var.region
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

data "aws_instances" "main" {
  filter {
    name   = "tag:Name"
    values = [var.instance_name]
  }
}

output "main" {
  value = length(data.aws_instances.main.ids) > 0 ? "Instance found: ${data.aws_instances.main.ids[0]}" : "Instance '${var.instance_name}' not found."
}

output "data_aws_instances_main_ids" {
  value = data.aws_instances.main.ids
}
output "data_aws_instances_main" {
  value = data.aws_instances.main
}
