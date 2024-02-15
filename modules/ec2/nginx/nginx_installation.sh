#!/bin/bash

#update package repo
sudo yum update -y

#install nginx
sudo yum install nginx -y

#start nginx service
sudo systemctl start nginx

#allow nginx to start on boot
sudo systemctl enable nginx