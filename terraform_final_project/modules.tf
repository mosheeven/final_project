data "aws_availability_zones" "available"{
  state = "available"
}

module "network" {
  source = "./modules/vpc"
  
  vpc_cidr = var.vpc_cidr
  private_subnet_vpc = var.public_subnet_vpc
  public_subnet_vpc = var.private_subnet_vpc
  AZ = data.aws_availability_zones.available.names
}