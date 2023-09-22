locals {
  all_cidr = values(var.sg.cidr)
  all_ip = flatten(local.all_cidr)
  trans = transpose(var.sg.cidr)
  product = setproduct(flatten(local.all_ip), var.sg.ports)
  group_data = [
    for pair in local.product: {
      CIDR: pair[0], 
      PORT: pair[1], 
      NAME: local.trans[pair[0]][0] 
    }
  ]
  chunks = chunklist(local.group_data,var.sg.max_alb_rules_limit)
  chunks_nested = [
    for pairs in local.chunks: [
      for pair in pairs: [{
        CIDR: pair["CIDR"], PORT: pair["PORT"], NAME: pair["NAME"]
      }]
    ]
  ]
  total_sg_to_create = length(local.chunks_nested)
  default_tags = {
    Environment = terraform.workspace
    Name        = "${var.sg.identifier}-${terraform.workspace}"
  }
  tags = merge(local.default_tags, var.sg.tags)
}

resource "aws_security_group" "sg" {
  count = local.total_sg_to_create > var.sg.max_security_groups_limit ? var.sg.max_security_groups_limit : local.total_sg_to_create
  name_prefix = var.sg.identifier
  description = "allow http and https for alb"
  vpc_id      = var.sg.vpc_id
  dynamic "ingress" {
    for_each = local.chunks_nested[count.index]
    content {
      from_port = ingress.value[0]["PORT"]
      to_port   = ingress.value[0]["PORT"]
      protocol  = "tcp"
      cidr_blocks = [ingress.value[0]["CIDR"]]
      description = ingress.value[0]["NAME"]
    }
  }
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = -1
    cidr_blocks     = [ "0.0.0.0/0" ]
  }

  tags = local.tags
}

