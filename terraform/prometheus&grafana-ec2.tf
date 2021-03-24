resource "aws_instance" "promethus_server" {
  count = var.promethus_count
  ami           = lookup(var.ami, var.region)
  instance_type = "t2.micro"
  key_name      = var.key_name

  iam_instance_profile   = aws_iam_instance_profile.consul-join.name
  vpc_security_group_ids = [aws_security_group.prometheus_grafana.id, aws_security_group.kandula_consul.id]
  subnet_id = element(module.vpc.private_subnet_ids, count.index)
  # associate_public_ip_address = true
  tags = {
    Name = "promethus_grafana-${count.index+1}"
    consul_server = "false"
    prometheus_server = "true"
    kandula_app = "true"
  }
}