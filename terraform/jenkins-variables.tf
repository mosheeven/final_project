locals {
  jenkins_home = "/home/ubuntu/jenkins_home"
  jenkins_home_mount = "${local.jenkins_home}:/var/jenkins_home"
  docker_sock_mount = "/var/run/docker.sock:/var/run/docker.sock"
  java_opts = "JAVA_OPTS='-Djenkins.install.runSetupWizard=false'"
}

variable "jenkins_server_count" {
    default = 1
}


variable "jenkins_slave_count" {
    default = 1
}

variable "jenkins_default_name" {
  default = "jenkins-kandula"
}