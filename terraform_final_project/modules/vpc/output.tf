output "vpc_vpc_id" {
  description = "ARN of the bucket"
  value       = aws_vpc.main.id
}

## Public
output "public_subnet_vpc_ids" {
  description = "Domain name of the bucket"
  value       = aws_subnet.public_kandula.*.id
}

# ## Private
# output "private_subnet_vpc_ids" {
#   description = "Name (id) of the bucket"
#   value       = aws_subnet.private_kandula.*.id
# }
