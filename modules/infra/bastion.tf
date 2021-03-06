locals {
  bastion_ssh_user = "${(var.use_community) ? "centos" : "ec2-user"}"
}

resource "aws_launch_template" "bastion" {
  name_prefix = "${var.platform_name}-bastion-"

  block_device_mappings {
    device_name = "${local.base_image_root_device_name}"

    ebs {
      volume_size = 32
    }
  }

  disable_api_termination = true

  #"${local.base_image_id}" 
  image_id = "ami-0aadff142eae62b97"

  instance_type = "t2.medium"

  iam_instance_profile {
    arn = "${aws_iam_instance_profile.bastion.arn}"
  }

  key_name = "${aws_key_pair.platform.id}"

  tag_specifications {
    resource_type = "instance"

    tags = "${map(
      "kubernetes.io/cluster/${var.platform_name}", "owned",
      "Name", "${var.platform_name}-bastion",
      "Role", "bastion"
    )}"
  }

  user_data = "${base64encode(data.template_file.bastion_init.rendered)}"

  vpc_security_group_ids = ["${aws_security_group.bastion.id}"]
}

resource "aws_autoscaling_group" "bastion" {
  name                = "${var.platform_name}-bastion"
  vpc_zone_identifier = ["${var.public_subnet_ids}"]
  desired_capacity    = 1
  max_size            = 1
  min_size            = 1
  force_delete        = false
  health_check_grace_period = 600  

  launch_template = {
    id      = "${aws_launch_template.bastion.id}"
    version = "$$Latest"
  }
}