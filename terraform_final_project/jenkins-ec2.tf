resource "aws_instance" "jenkins_server_consul" {
  count = var.jenkins_server_count
  ami           = lookup(var.ami, var.region)
  instance_type = "t2.micro"
  key_name      = var.key_name

  iam_instance_profile   = aws_iam_instance_profile.consul-join.name
  vpc_security_group_ids = [aws_security_group.jenkins_kandula.id, aws_security_group.kandula_consul.id]
  subnet_id = element(module.vpc.public_subnet_ids, count.index)
  associate_public_ip_address = true
  user_data = "jenkins_master"
  tags = {
    Name = "jenkins-master-kandula-${count.index+1}"
    consul_server = "false"
    jenkins = "true"
    kandula_app = "true"
  }
}


resource "aws_instance" "jenkins_slave_consul" {
  count = var.jenkins_slave_count
  ami           = lookup(var.ami, var.region)
  instance_type = "t2.micro"
  key_name      = var.key_name

  iam_instance_profile   = aws_iam_instance_profile.consul-join.name
  vpc_security_group_ids = [aws_security_group.kandula_consul.id]
  subnet_id = element(module.vpc.public_subnet_ids, count.index)
  associate_public_ip_address = true
  user_data = "jenkins_slave"
  tags = {
    Name = "jenkins-slave-kandula-${count.index+1}"
    consul_server = "false"
    jenkins = "true"
    kandula_app = "true"
  }
  
}
