variable "rh_subscription_pool_id" {
  description = "Red Hat subscription pool id for OpenShift Container Platform"
  default     = ""
}

variable "rhn_username" {
  description = "Red Hat Network login username for registration system of the OpenShift Container Platform cluster"
  default     = ""
}

variable "rhn_password" {
  description = "Red Hat Network login password for registration system of the OpenShift Container Platform cluster"
  default     = ""
}

variable "bastion_ssh_user" {}

variable "bastion_private_key" {}

variable "bastion_endpoint" {}

variable "openshift_major_version" {
  default = "3.11"
}

variable "use_community" {
  default = false
}
variable "platform_name" {}

variable "platform_domain" {}

variable "platform_app_domain" {}

variable "platform_private_domain" {}

variable "platform_public_domain" {}

variable "public_certificate_pem" {
  default = ""
}

variable "public_certificate_key" {
  default = ""
}

variable "public_certificate_intermediate_pem" {
  default = ""
}

variable "master_nodes" { type = "list" }