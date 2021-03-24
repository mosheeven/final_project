data "aws_availability_zones" "available"{
  state = "available"
}
locals {
  cluster_name = "opsschool-eks-${random_string.suffix.result}"
}
resource "random_string" "suffix" {
  length  = 8
  special = false
}

module "vpc" {
  source = "./modules/vpc"
  aws_region = var.region
  public_subnet_vpc = var.public_subnet_vpc
  private_subnet_vpc = var.private_subnet_vpc
  vpc_name = "kalandula-vpc"
  cidr_network = var.vpc_cidr

  tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
  }

  public_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                      = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"             = "1"
  }

}