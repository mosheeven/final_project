
resource "aws_instance" "elasticsearch_kibana" {
  count = var.elasticsearch_instance_count
  ami           = lookup(var.ami, var.region)
  instance_type = "t3.medium"
  key_name      = var.key_name
  iam_instance_profile   = aws_iam_instance_profile.consul-join.name

  vpc_security_group_ids = [module.security-group.this_security_group_id, aws_security_group.kandula_consul.id]
  subnet_id = element(module.vpc.private_subnet_ids, count.index)

  user_data = "elasticsearch_kibana"
  tags = {
    Name = "elasticsearch_kibana-${count.index+1}"
    consul_server = "false"
    elasticsearch_kibana = "true"
    kandula_app = "true"
  }
}

