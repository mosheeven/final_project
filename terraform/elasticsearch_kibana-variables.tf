
# variable "aws_profile" {
#   type    = string
#   default = "default"
# }
# variable "ssh_key_name" {
#   type = string
# }
variable "prefix_name" {
    default = "kandula"
  type = string
}
variable "elasticsearch_instance_count" {
  type    = number
  default = 1
}