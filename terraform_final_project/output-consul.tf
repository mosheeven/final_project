output "server" {
  value = aws_instance.consul_server.*.public_dns
}

output "agent" {
  value = aws_instance.jenkins_server_consul.*.public_dns
}
