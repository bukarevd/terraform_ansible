#!/usr/bin/env bash
terraform init
terraform plan
yes yes | terraform apply
terraform output nodes > nodes.txt
touch ./ansible/hosts
echo "[nodes]" > ./ansible/hosts
awk -F, '{print $1}' nodes.txt >> ./ansible/hosts
rm nodes.txt
cd ansible
terraform init && terraform plan
yes yes | terraform apply
rm hosts