output "master" {
  value = "${aws_instance.aws_master_instance.public_ip}"
}

output "nodes" {
  value = "${aws_instance.aws_instance.*.public_ip}"
}