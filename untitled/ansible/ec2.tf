provider "aws" {
  region = "us-east-1"
}

data "aws_vpc" "vpc" {
}

data "aws_security_groups" "security" {
  filter {
    name = "vpc-id"
    values = ["${data.aws_vpc.vpc.id}"]
  }
}

output "vpc" {
  value = "${data.aws_vpc.vpc.id}"
}

output "" {
  value = "${data.aws_security_groups.security.ids}"
}

variable "private_key" {
  default = "~/.ssh/NVirginia_home.pem"
}

variable "user_name" {
  default = "ubuntu"
}
resource "aws_instance" "redhat_instance" {
  ami = "ami-0a313d6098716f372"
  instance_type = "t2.micro"
  vpc_security_group_ids = ["${data.aws_security_groups.security.ids}"]
  key_name = "NVirginia_home"
  tags {
    Name = "${var.user_name}"
  }


  provisioner "file" {
    source = "script.sh"
    destination = "/home/${var.user_name}/script.sh"
    connection {
      type = "ssh"
      user = "${var.user_name}"
      private_key = "${file("~/.ssh/NVirginia_home.pem")}"
    }
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /home/${var.user_name}/script.sh",
      "./script.sh",
    ]
    connection {
      type = "ssh"
      user = "${var.user_name}"
      private_key = "${file("~/.ssh/NVirginia_home.pem")}"
    }
  }

  provisioner "file" {
    source = "hosts"
    destination = "/home/${var.user_name}/ansible/hosts"
    connection {
      type = "ssh"
      user = "${var.user_name}"
      private_key = "${file("~/.ssh/NVirginia_home.pem")}"
    }
  }

  provisioner "file" {
    source = "~/.ssh/NVirginia_home.pem"
    destination = "~/.ssh/NVirginia_home.pem"
  }
  connection {
    type = "ssh"
    user = "${var.user_name}"
    private_key = "${file("~/.ssh/NVirginia_home.pem")}"
  }
}

output "ubuntu" {
  value = "${aws_instance.redhat_instance.public_ip}"
}
