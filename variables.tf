
variable "openvpn" {
  type = object({
    identifier = string
    ami_id = string
    subnet_id = string
    vpc_id = string
    instance_type = string
    disable_api_termination = bool
    key_name = string
    ebs_volume_id = string
    ebs_device_name = string
    tags = map(string)
  })
}
variable "sg" {
  type = object({
    identifier = string
    vpc_id = string
    max_alb_rules_limit = number
    max_security_groups_limit = number
    cidr = map(list(string))
    ports = list(number)
    tags = map(string)
  })
}
