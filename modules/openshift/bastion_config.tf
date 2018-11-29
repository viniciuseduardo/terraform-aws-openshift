data "template_file" "bastion_config_playbook" {
  template = "${file("${path.module}/resources/bastion-config-playbook.yaml")}"

  vars {
    openshift_major_version = "${var.openshift_major_version}"
  }
}

resource "null_resource" "bastion_config" {
  provisioner "file" {
    content     = "${data.template_file.bastion_config_playbook.rendered}"
    destination = "~/bastion-config-playbook.yaml"
  }

  provisioner "remote-exec" {
    inline = [
      "export ANSIBLE_HOST_KEY_CHECKING=False",
      "sudo yum install -y --enablerepo=epel pyOpenSSL python-passlib",
      "ansible-playbook -i localhost, -c local ~/bastion-config-playbook.yaml",
      "echo 'Configurated'"
    ]
  }

  connection {
    type        = "ssh"
    user        = "${var.bastion_ssh_user}"
    private_key = "${var.platform_private_key}"
    host        = "${var.bastion_endpoint}"
  }

  triggers {
    playbook = "${data.template_file.bastion_config_playbook.rendered}"
  }

  depends_on = ["null_resource.bastion_repos"]
}
