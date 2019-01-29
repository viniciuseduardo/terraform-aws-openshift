data "template_file" "data_hosts" {
  template = "${file("${path.module}/resources/hosts-details.tmpl")}"
  count    = "${length(var.master_nodes)}"

  vars {
    hostname = "${element(keys(var.master_nodes[count.index]), 0)}"
    labels = "${element(values(var.master_nodes[count.index]), 0)}"
  }
}

data "template_file" "template_inventory" {
  template = "${file("${path.module}/resources/template-inventory.yaml")}"

  vars {
    ansible_user                   = "${var.bastion_ssh_user}"
    
    named_certificate              = "${(var.public_certificate_pem == "") ? false : true}"
    openshift_deployment_type      = "${var.use_community ? "origin" : "openshift-enterprise"}"
    openshift_major_version        = "${var.openshift_major_version}"
    openshift_repos_enable_testing = "${var.use_community ? "true" : "false"}"    
    platform_domain                = "${var.platform_domain}"
    platform_app_domain            = "${var.platform_app_domain}"
    platform_private_domain        = "${var.platform_private_domain}"
    platform_public_domain         = "${var.platform_public_domain}"
    platform_name                  = "${var.platform_name}"    
    rhn_username                   = "${var.rhn_username}"
    rhn_password                   = "${var.rhn_password}"
    rh_subscription_pool_id        = "${var.rh_subscription_pool_id}"

    master_nodes = "${join("\n", data.template_file.data_hosts.*.rendered)}"
  }
}

resource "null_resource" "template_inventory" {
  provisioner "file" {
    content     = "${data.template_file.template_inventory.rendered}"
    destination = "~/inventory.yaml"
  }

  connection {
    type        = "ssh"
    user        = "${var.bastion_ssh_user}"
    private_key = "${var.bastion_private_key}"
    host        = "${var.bastion_endpoint}"
  }

  triggers {
    template_inventory = "${data.template_file.template_inventory.rendered}"
  }
}