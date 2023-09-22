sg ={
      identifier = "web_sg"
      max_alb_rules_limit = 50
      max_security_groups_limit = 5
      vpc_id = "vpc-04dd420858816a5bb"
      cidr = {
          "james @ USA"           = [ "0.0.0.0/0" ]
      }
      ports = [443, 22 , 945 , 943 , 1194]
      tags = {}
}


openvpn = {
  identifier = "Ops" 
  ami_id = "ami-0c19fd760bfd1c868"
  subnet_id = "subnet-09d85928c4c0ebb87"  # subnet ID
  vpc_id = "vpc-04dd420858816a5bb"  # vpc ID
  instance_type = "t2.micro"
  disable_api_termination = true
  key_name = "key_pair" # key pair
  ebs_volume_id = "vol-020d6bb4ed73e15ac" # volume id
  ebs_device_name = "/dev/sda1" 
  tags = {}
}
