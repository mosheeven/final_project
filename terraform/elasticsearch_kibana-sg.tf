module "security-group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "3.17.0"

  name   = "${var.prefix_name}-elk"
  vpc_id = module.vpc.vpc_id

  ingress_cidr_blocks = var.cidr_block
  ingress_rules = [
    "elasticsearch-rest-tcp",
    "elasticsearch-java-tcp",
    "kibana-tcp",
    "logstash-tcp",
    "ssh-tcp"
  ]
  ingress_with_self = [{ rule = "all-all" }]
  egress_rules      = ["all-all"]

}
resource "aws_security_group" "kandula_elk" {
  name        = "kandula-elk"
  description = "Allow ssh & consul inbound traffic"
  vpc_id = module.vpc.vpc_id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    self        = true
    description = "Allow all inside security group"
  }


  ingress {
    from_port   = 5601
    to_port     = 5601
    protocol    = "tcp"
    cidr_blocks = var.cidr_block
    description = "Kibana"
  }

  ingress {
    from_port   = 9200
    to_port     = 9200
    protocol    = "tcp"
    cidr_blocks = var.cidr_block
    description = "elastic"
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
    description     = "Allow all outside security group"
  }
}