variable "instances_name" {
  type = "list"
  default = [
            "first",
            "second"]
}

resource "aws_instance" "aws_instance" {
  count = "${length(var.instances_name)}"
  ami = "ami-0a313d6098716f372"
  instance_type = "t2.micro"
  key_name = "NVirginia"
  vpc_security_group_ids = ["${aws_security_group.MY_Security_Group.id}"]
  tags {
    Name = "${element(var.instances_name, count.index)}"
  }
}

resource "aws_instance" "aws_master_instance" {
  ami = "ami-0a313d6098716f372"
  instance_type = "t2.micro"
  key_name = "NVirginia"
  vpc_security_group_ids = ["${aws_security_group.MY_Security_Group.id}"]
  user_data = <<-EOF
              #!/bin/bash
              apt-get update -y
              apt-get upgrade -y
              apt-get install -y ansible
              mkdir ansible
              touch /home/ubuntu/ansible/hosts.txt
              touch /home/ubuntu/.ssh/Nvirginia.pem
              EOF
  tags {
    Name = "Master"
  }
}






