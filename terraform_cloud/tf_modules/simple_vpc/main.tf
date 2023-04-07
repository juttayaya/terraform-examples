################################################################################
# VPC Module
################################################################################
module "terraform_simple_vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.19.0"

  name = "${local.name_prefix}-vpc"
  cidr = var.cidr

  azs                  = var.azs
  public_subnets       = var.public_subnets
  public_subnet_suffix = "subnet-public"

  enable_ipv6             = false
  map_public_ip_on_launch = true
  enable_dns_hostnames    = true

  create_igw             = true
  create_egress_only_igw = false
  enable_nat_gateway     = false

  igw_tags = {
    Name = "${local.name_prefix}-igw"
  }

  public_route_table_tags = {
    Name = "${local.name_prefix}-route-table-public"
  }
}
