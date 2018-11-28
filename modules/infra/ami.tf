data "aws_ami" "commercial" {
  most_recent = true

  owners = ["309956199498"]

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "block-device-mapping.volume-type"
    values = ["gp2"]
  }

  name_regex = "^RHEL-7.*"
}

data "aws_ami" "community" {
  most_recent = true

  owners = ["679593333241"]

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  name_regex = "^CentOS Linux 7.*"
}

locals {
  base_image_id               = "${var.use_community ? data.aws_ami.community.image_id : data.aws_ami.commercial.image_id}"
  base_image_root_device_name = "${var.use_community ? data.aws_ami.community.root_device_name : data.aws_ami.commercial.root_device_name}"
}
