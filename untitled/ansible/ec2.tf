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
  default = "~/.ssh/NVirginia.pem"
}
resource "aws_instance" "redhat_instance" {
  ami = "ami-0a313d6098716f372"
  instance_type = "t2.micro"
  vpc_security_group_ids = ["${data.aws_security_groups.security.ids}"]
  key_name = "NVirginia"
  tags {
    Name = "Ubuntu"
  }


  provisioner "file" {
    source = "script.sh"
    destination = "/home/ec2-user/script.sh"
    connection {
      type = "ssh"
      user = "ec2-user"
      private_key = "${file("~/.ssh/NVirginia.pem")}"
    }
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /home/ec2-user/script.sh",
      "./script.sh",
    ]
    connection {
      type = "ssh"
      user = "ec2-user"
      private_key = "${file("~/.ssh/NVirginia.pem")}"
    }
  }

  provisioner "file" {
    source = "hosts"
    destination = "/home/ec2-user/ansible/hosts"
    connection {
      type = "ssh"
      user = "ec2-user"
      private_key = "${file("~/.ssh/NVirginia.pem")}"
    }
  }

  provisioner "file" {
    source = "~/Загрузки/NVirginia.pem"
    destination = "~/.ssh/NVirginia.pem"
  }
  connection {
    type = "ssh"
    user = "ec2-user"
    private_key = "${file("~/Загрузки/NVirginia.pem")}"
  }
}
