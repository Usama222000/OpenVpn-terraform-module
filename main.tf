
module openvpn {
    source = "./modules/OPENVPN"
    openvpn = var.openvpn
    sg = module.SG.security-group-ids
}

module "SG" {
   source = "./modules/SG"
   sg = var.sg
}