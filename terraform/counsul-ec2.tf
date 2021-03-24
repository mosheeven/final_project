resource "aws_instance" "consul_server" {
  count = var.consul_server_count
  ami           = lookup(var.ami, var.region)
  instance_type = "t2.micro"
  key_name      = var.key_name
  
  iam_instance_profile   = aws_iam_instance_profile.consul-join.name
  vpc_security_group_ids = [aws_security_group.kandula_consul.id]
  subnet_id = element(module.vpc.private_subnet_ids, count.index)

  tags = {
    Name = "kandula-consul-server-${count.index+1}"
    consul_server = "true"
    kandula_app = "true"
  }
}
