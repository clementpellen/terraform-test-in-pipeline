# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

variable "region" {
  type        = string
  description = "AWS region for all resources."

  default = "us-east-1"
}

variable "project_name" {
  type        = string
  description = "Name of the example project."

  default = "terraform-init"
}

variable "instance_name" {
  type        = string
  description = "Name of the EC2 instance."

  default = "my-ec2-instance"

}

variable "instance_type" {
  type        = string
  description = "Instance type for the EC2 instance."

  default = "t2.micro"
}
