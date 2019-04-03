#!/usr/bin/env bash
sudo echo "---------------START----------------"
sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-add-repository --yes --update ppa:ansible/ansible
sudo apt-get install ansible -y
chmod 400 ~/.ssh/NVirginia.pem
mkdir ansible
sudo echo "--------------END-------------------"