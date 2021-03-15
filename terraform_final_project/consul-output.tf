output "consul-servers" {
  value = aws_instance.consul_server.*.public_dns
}
