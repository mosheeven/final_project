
# resource "aws_security_group" "jenkins_kandula" {
#   name = local.jenkins_default_name
#   description = "Allow Jenkins inbound traffic"
#   vpc_id = module.vpc.vpc_id

#   ingress {
#     from_port = 443
#     to_port = 443
#     protocol = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   ingress {
#     from_port = 8080
#     to_port = 8080
#     protocol = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   ingress {
#     from_port = 22
#     to_port = 22
#     protocol = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   egress {
#     description = "Allow all outgoing traffic"
#     from_port = 0
#     to_port = 0
#     // -1 means all
#     protocol = "-1"
#     cidr_blocks = [
#       "0.0.0.0/0"
#     ]
#   }
  
#   tags = {
#     Name = local.jenkins_default_name
#   }
# }


# locals {
#   server_count = 1
#   jenkins_default_name = "jenkins_kandula"
#   jenkins_home = "/home/ubuntu/jenkins_home"
#   jenkins_home_mount = "${local.jenkins_home}:/var/jenkins_home"
#   docker_sock_mount = "/var/run/docker.sock:/var/run/docker.sock"
#   java_opts = "JAVA_OPTS='-Djenkins.install.runSetupWizard=false'"
# }


# resource "aws_instance" "jenkins_server_consul" {
#   count = local.server_count
#   ami           = lookup(var.ami, var.region)
#   instance_type = "t2.micro"
#   key_name      = var.key_name

#   iam_instance_profile   = aws_iam_instance_profile.consul-join.name
#   vpc_security_group_ids = [aws_security_group.kandula_consul.id]
#   subnet_id = element(module.vpc.public_subnet_ids, count.index)
#   associate_public_ip_address = true
#   tags = {
#     Name = "kandula-jenkins-master"
#     consul_server = "true"
#   }

#   connection {
#     host = aws_instance.jenkins_server_consul[count.index].public_ip
#     user = "ubuntu"
#     private_key = file("moshe-us-east-1-private")
#   }

#   provisioner "file" {
#     source      = "scripts/consul-jenkins-master.sh"
#     destination = "/home/ubuntu/consul-agent.sh"
#   }

#   provisioner "remote-exec" {
#     inline = [
#       "sudo apt-get update -y",
#       "sudo apt install docker.io -y",
#       "sudo systemctl start docker",
#       "sudo systemctl enable docker",
#       "sudo usermod -aG docker ubuntu",
#       "mkdir -p ${local.jenkins_home}",
#       "sudo chown -R 1000:1000 ${local.jenkins_home}"
#     ]
#   }
#   provisioner "remote-exec" {
#     inline = [
#       "sudo docker run -d --restart=always -p 8080:8080 -p 50000:50000 -v ${local.jenkins_home_mount} -v ${local.docker_sock_mount} --env ${local.java_opts} jenkins/jenkins",
#       "sudo bash /home/ubuntu/consul-agent.sh"
#     ]
#   }
# }


# resource "aws_instance" "jenkins_slave_consul" {
#   count = local.server_count
#   ami           = lookup(var.ami, var.region)
#   instance_type = "t2.micro"
#   key_name      = var.key_name

#   iam_instance_profile   = aws_iam_instance_profile.consul-join.name
#   vpc_security_group_ids = [aws_security_group.kandula_consul.id]
#   subnet_id = element(module.vpc.public_subnet_ids, count.index)
#   associate_public_ip_address = true
#   tags = {
#     Name = "kandula-jenkins-slave"
#     consul_server = "true"
#   }

#   connection {
#     host = aws_instance.jenkins_server_consul[count.index].public_ip
#     user = "ubuntu"
#     private_key = file("moshe-us-east-1-private")
#   }

#   provisioner "file" {
#     source      = "scripts/consul-jenkins-slave.sh"
#     destination = "/home/ubuntu/consul-agent.sh"
#   }

#   provisioner "remote-exec" {
#     inline = [
#       "sudo apt-get update -y",
#       "sudo apt install docker.io -y",
#       "sudo systemctl start docker",
#       "sudo systemctl enable docker",
#       "sudo usermod -aG docker ubuntu",
#       "mkdir -p ${local.jenkins_home}",
#       "sudo chown -R 1000:1000 ${local.jenkins_home}"
#     ]
#   }
#   provisioner "remote-exec" {
#     inline = [
#       "sudo bash /home/ubuntu/consul-agent.sh"
#     ]
#   }
# }
