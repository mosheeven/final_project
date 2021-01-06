data "aws_availability_zones" "available"{
  state = "available"
}

module "vpc" {
  source = "./modules/vpc"
  aws_region = var.region
  public_subnet_vpc = var.public_subnet_vpc
  private_subnet_vpc = var.private_subnet_vpc
  vpc_name = "kalandula-vpc"
  cidr_network = var.vpc_cidr
}