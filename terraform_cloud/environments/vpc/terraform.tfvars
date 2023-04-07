# These Terraform environment variables are duplicated each resource terraform.tfvars
# In Terragrunt, these variables are consolidated in one env.hcl
project_name = "delve.bio"
app_id       = "delve-product"

environment_name = "development"
aws_region       = "us-east-2"

# Module variables
# Note that terraform.tfvars are constants and cannot interpolate other variables like "${var.aws_region}a"
# Specifically picking non 10.0.0.0/8 subnets for demo
azs          = ["us-east-2a", "us-east-2b"]
cidr         = "192.168.0.0/16"
public_subnets      = ["192.168.101.0/24", "192.168.102.0/24"]
