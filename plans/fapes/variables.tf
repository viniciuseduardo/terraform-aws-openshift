variable "use_community" {}
variable "platform_name" {}

variable "platform_domain" {}

variable "platform_domain_administrator_email" {}

variable "platform_app_domain" {}

variable "platform_private_domain" {}

variable "platform_public_domain" {}

variable "bastion_ssh_user" {}

variable "bastion_private_key" {}

variable "bastion_endpoint" {}

variable "create" {}
variable "name" {}
variable "algorithm" {}
variable "rsa_bits" {}
variable "validity_period_hours" {}
variable "organization_name" {}
variable "ip_addresses" { type = "list" }
variable "master_nodes" { type = "list" }
variable "infra_nodes" { type = "list" }
variable "lb_nodes" { type = "list" }
variable "app_prod_nodes" { type = "list" }
variable "app_hmg_nodes" { type = "list" }
variable "app_dev_nodes" { type = "list" }
