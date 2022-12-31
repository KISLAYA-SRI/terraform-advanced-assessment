#!/bin/sh
sudo apt update
sudo apt install nginx
echo "Hi, Welcome to Terraform Demo by Kislaya!"
sudo systemctl reload nginx
sudo systemctl enable nginx