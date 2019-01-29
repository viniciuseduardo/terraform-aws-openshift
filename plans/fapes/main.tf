module "security" {
  source = "../../modules/security"

  create                = "${var.create}"
  name                  = "${var.name}"
  algorithm             = "${var.algorithm}"
  rsa_bits              = "${var.rsa_bits}"
  validity_period_hours = "${var.validity_period_hours}"
  organization_name     = "${var.organization_name}"
  ca_common_name        = "${var.platform_domain}"  
  common_name           = "${var.platform_domain}"
  dns_names             = ["${var.platform_domain}", "*.${var.platform_domain}" ]
  ip_addresses          = "${var.ip_addresses}"
  download_certs        = true
}

module "bastion" {
  source = "../../modules/bastion"

  use_community = "${var.use_community}"

  bastion_ssh_user        = "${var.bastion_ssh_user}"
  bastion_private_key     = "${file("${var.bastion_private_key}")}"
  bastion_endpoint        = "${var.bastion_endpoint}"

  platform_name                       = "${var.platform_name}"
  platform_domain                     = "${var.platform_domain}"
  platform_app_domain                 = "${var.platform_app_domain}"
  platform_private_domain             = "${var.platform_private_domain}"
  platform_public_domain              = "${var.platform_public_domain}"
  public_certificate_pem              = "${module.security.leaf_cert_pem}"
  public_certificate_key              = "${module.security.leaf_private_key_pem}"
  public_certificate_intermediate_pem = "${module.security.ca_cert_pem}"

  master_nodes = "${var.master_nodes}"
}

terraform {
  backend "s3" {
    bucket="sysmi-devops"
    key="openshift-factory/fapes-terraform.tfstate"
    region="us-east-1"
  }
}