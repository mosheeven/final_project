
provider "aws" {
  region = var.aws_region

}

data "aws_availability_zones"  "available" {}

# VPC Creation

resource "aws_vpc"  "vpc_main" {

  cidr_block =  var.cidr_network 
  enable_dns_hostnames = "true"
  tags = {
    Name = var.vpc_name
  }

}
# Internet Gateway Creation

resource "aws_internet_gateway"  "vpc_igw" {

  vpc_id = aws_vpc.vpc_main.id
  tags = {
    Name = "myIGW"
  }  
}


# Subnets configuration 

resource "aws_subnet"  "public_subnet" {
  count = length(var.public_subnet_vpc)
  cidr_block = var.public_subnet_vpc[count.index]
  vpc_id = aws_vpc.vpc_main.id
  map_public_ip_on_launch = "true"
  availability_zone = data.aws_availability_zones.available.names[count.index]
  
  tags = merge(
    var.tags,
    var.public_subnet_tags,
  )

}


resource "aws_subnet"  "private_subnet" {
  count = length(var.private_subnet_vpc)
  cidr_block = var.private_subnet_vpc[count.index]
  vpc_id = aws_vpc.vpc_main.id
  map_public_ip_on_launch = "true"
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = merge(
    var.tags,
    var.private_subnet_tags,
  )
}

# Routing IGW Configuration

resource "aws_route_table" "rt_public"{
  #count = 2
  vpc_id = aws_vpc.vpc_main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vpc_igw.id
    }

}

resource "aws_route_table_association" "rta-subnet1-public" {

  count = 2
  subnet_id = aws_subnet.public_subnet[count.index].id 
  route_table_id = aws_route_table.rt_public.id 
}


#Nat Gateway Creation

resource "aws_eip" "ip_nat"{
  vpc = "true"
  count = 2 
}

resource "aws_nat_gateway" "gw_nat" {
  count = 2
  allocation_id = aws_eip.ip_nat[count.index].id
  subnet_id = aws_subnet.public_subnet[count.index].id
  depends_on    = [aws_internet_gateway.vpc_igw]



  tags = {
    Name = "MyNAT"
  }
}

#Routing Nat Configurationm

resource "aws_route_table" "rt_private"{
  vpc_id = aws_vpc.vpc_main.id
  count =2
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.gw_nat[count.index].id
    }

}

resource "aws_route_table_association" "rta-subnet2-private" {
  count = 2
  subnet_id = aws_subnet.private_subnet[count.index].id 
  route_table_id = aws_route_table.rt_private[count.index].id 
}