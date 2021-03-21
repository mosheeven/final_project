# resource "aws_route53_zone" "private" {
#   name = "kandula.com"

#   vpc {
#     vpc_id = module.vpc.vpc_id
#   }
# }


# resource "aws_route53_record" "grafana" {
#  zone_id = aws_route53_zone.private.zone_id
#  name    = "grafana.${aws_route53_zone.private.name}"
#  type    = "A"
#  ttl     = "60"
#  records = [aws_instance.promethus_server[0].private_ip]
# }