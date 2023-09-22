locals {
  default_tags = {
    Environment = terraform.workspace
    Name        = "${var.openvpn.identifier}-${terraform.workspace}"
  }
  tags = merge(local.default_tags, var.openvpn.tags)
}

resource "aws_instance" "web" {
  associate_public_ip_address = true
  vpc_security_group_ids      = var.sg
  instance_type               = var.openvpn.instance_type
  subnet_id                   = var.openvpn.subnet_id
  ami                         = var.openvpn.ami_id
  tags                        = local.tags
  disable_api_termination     = var.openvpn.disable_api_termination
}

resource "aws_volume_attachment" "ebs_att" {
  device_name = var.openvpn.ebs_device_name
  volume_id   = var.openvpn.ebs_volume_id
  instance_id = aws_instance.web.id
}
