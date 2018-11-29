locals {
  content_file = "${(var.use_community) ? data.template_file.bastion_repos_centos.rendered : data.template_file.bastion_repos_rhel.rendered}"
}

data "template_file" "bastion_repos_rhel" {
  template = "${file("${path.module}/resources/bastion-repos-rhel.sh")}"

  vars {
    platform_name           = "${var.platform_name}"
    rhn_username            = "${var.rhn_username}"
    rhn_password            = "${var.rhn_password}"
    rh_subscription_pool_id = "${var.rh_subscription_pool_id}"
    openshift_major_version = "${var.openshift_major_version}"
  }
}

data "template_file" "bastion_repos_centos" {
  template = "${file("${path.module}/resources/bastion-repos-centos.sh")}"

  vars {
    platform_name           = "${var.platform_name}"
    rhn_username            = "${var.rhn_username}"
    rhn_password            = "${var.rhn_password}"
    rh_subscription_pool_id = "${var.rh_subscription_pool_id}"
    openshift_major_version = "${var.openshift_major_version}"
  }
}

resource "null_resource" "bastion_repos" {
  provisioner "file" {
    content     = "${local.content_file}"
    destination = "~/bastion-repos.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x ~/bastion-repos.sh",
      "sh ~/bastion-repos.sh",
    ]
  }

  connection {
    type        = "ssh"
    user        = "${var.bastion_ssh_user}"
    private_key = "${var.platform_private_key}"
    host        = "${var.bastion_endpoint}"
  }

  triggers {
    script = "${local.content_file}"
  }
}
