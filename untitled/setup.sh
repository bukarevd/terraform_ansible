#!/usr/bin/env bash
terraform init
terraform plan
yes yes | terraform apply
terraform output nodes > nodes.txt
touch hosts && echo "[nodes]" > /ansible/hosts
cat nodes.txt | awk -F, '{print $1}' >> ./ansible/hosts
rm nodex.txt
cd ansible
terraform init && terraform plan
yes yes | terraform apply
rm hosts
