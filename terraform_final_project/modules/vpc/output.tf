output "vpc_id" {
    description = "ID of the VPC"
    value = aws_vpc.vpc_main.id
}

output "public_subnet_ids" {
    description = "List with IDs of the public subnets"
    value = aws_subnet.public_subnet.*.id
}

output "private_subnet_ids" {
    description = "List with IDs of the private subnets"
    value = aws_subnet.private_subnet.*.id
}