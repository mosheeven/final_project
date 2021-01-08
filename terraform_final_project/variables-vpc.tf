variable "region" {
    default = "us-east-2"
}

variable "key_name" {
  description = "name of ssh key to attach to hosts"
  default = "moshe-east-2"
}

variable "vpc_cidr" {
    default = "10.0.0.0/16"
}

variable "public_subnet_vpc" {
    default = ["10.0.1.0/24" , "10.0.50.0/24"]
}

variable "private_subnet_vpc" {
    default = ["10.0.100.0/24", "10.0.150.0/24"]
}

