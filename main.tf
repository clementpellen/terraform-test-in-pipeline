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

data "aws_instances" "vms_by_name" {
  filter {
    name   = "tag:Name"
    values = [var.instance_name]
  }
}

data "aws_instance" "vm_by_name" {
  count       = length(data.aws_instances.vms_by_name.ids)
  instance_id = data.aws_instances.vms_by_name.ids[count.index]
}

output "vm_by_name_report" {
  value = length(data.aws_instances.vms_by_name.ids) > 0 ? "Instances found: ${join(", ", data.aws_instances.vms_by_name.ids)}" : "Instance '${var.instance_name}' not found."
}

