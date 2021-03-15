resource "aws_security_group" "jenkins_kandula" {
  name = var.jenkins_default_name
  description = "Allow Jenkins inbound traffic"
  vpc_id = module.vpc.vpc_id

  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = var.cidr_block
  }

  ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = var.cidr_block
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = var.cidr_block
  }

  egress {
    description = "Allow all outgoing traffic"
    from_port = 0
    to_port = 0
    // -1 means all
    protocol = "-1"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }
  
  tags = {
    Name = "Jenkins-sg-kandula"
  }
}
