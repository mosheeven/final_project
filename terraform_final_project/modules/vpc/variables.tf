
# AWS Regions / Zones
variable "aws_region" {
  type = string
  description = "AWS region which should be used"
}

# Private subnets
variable "private_subnet_vpc" {
  description = "Create private  subnets"
  type = list
}

# Public  subnets
variable "public_subnet_vpc" {
  description = "Create public  subnets"
  type = list
}

# Resource naming
variable "vpc_name" {
  description = "Name of the VPC"
  type = string
}

# Network details
variable "cidr_network" {
  type = string
  description = "CIDR of the VPC"
}
