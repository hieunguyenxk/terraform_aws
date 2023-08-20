#!/bin/bash
sudo apt update -y &&
sudo apt install -y nginx
echo "Nginx Demo Terraform" > /var/www/html/index.html