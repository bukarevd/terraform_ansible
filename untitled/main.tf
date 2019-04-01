provider "aws" {
  region = "us-east-1"
}

module "ansible_hosts" {
  source = "./backend"
}

output "master" {
  value = "${module.ansible_hosts.master}"
}

output "nodes" {
  value = "${module.ansible_hosts.nodes}"
}

