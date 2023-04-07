# In Terraform, you have to declare duplicate environment_name and aws_region in all
# the resources variables.tf
# In Terragrunt, these environment common variables are defined in one env.hcl
# Terragrunt automatically uses the variables without having to explicitly declare them
variable "project_name" {
  type = string
}

variable "app_id" {
  type = string
}

variable "environment_name" {
  type        = string
  description = "Name of environment"
}

variable "aws_region" {
  type        = string
  description = "The AWS region of the deployment"
}


variable "azs" {
  type        = list(string)
  description = "The Availability Zones of the deployment"
}

variable "cidr" {
  type        = string
  description = "The IPv4 CIDR of the VPC"
}

variable "public_subnets" {
  type        = list(string)
  description = "The IPv4 public subnets for aws_cidr"
}