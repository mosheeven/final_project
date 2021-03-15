variable "region" {
    default = "us-east-1"
}

variable "key_name" {
  description = "name of ssh key to attach to hosts"
  default = "moshe-us-east-1-private"
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

variable "ami" {
  description = "ami (ubuntu 18) to use - based on region"
  default = {
    "us-east-1" = "ami-00ddb0e5626798373"
    "us-east-2" = "ami-0dd9f0e7df0f0a138"
  }
}

variable "cidr_block" {
  type = list(string)
  default = [ "80.179.0.0/16", "172.31.0.0/16", "10.0.0.0/16", "37.142.10.0/24", "31.154.0.0/16" ]
}
