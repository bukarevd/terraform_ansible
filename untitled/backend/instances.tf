variable "instances_name" {
  type = "list"
  default = [
            "first",
            "second"]
}

variable "key" {
  default = "NVirginia"
}

resource "aws_instance" "aws_instance" {
  count = "${length(var.instances_name)}"
  ami = "ami-0a313d6098716f372"
  instance_type = "t2.micro"
  key_name = "${var.key}"
  vpc_security_group_ids = ["${aws_security_group.MY_Security_Group.id}"]
  tags {
    Name = "${element(var.instances_name, count.index)}"
  }
}

resource "aws_instance" "aws_master_instance" {
  ami = "ami-0a313d6098716f372"
  instance_type = "t2.micro"
  key_name = "${var.key}"
  vpc_security_group_ids = ["${aws_security_group.MY_Security_Group.id}"]
  tags {
    Name = "Master"
  }
}






