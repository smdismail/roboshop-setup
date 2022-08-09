#!/usr/bin/env bash
#Running Roboshop Frontend with Sudo permission

source components/common.sh

checkRootUser

echo "installing nginx"
yum install nginx -y >/tmp/roboshop.log
statusCheck $?

echo "downloading frontend code"
curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip" >/tmp/roboshop.log
statusCheck $?
cd /usr/share/nginx/html

echo "removing old files"
rm -rf * >/tmp/roboshop.log
statusCheck $?

echo "extracting zip content"
unzip /tmp/frontend.zip >/tmp/roboshop.log
statusCheck $?

echo "copying extracted content"
mv frontend-main/* . >/tmp/roboshop.log
mv static/* . >/tmp/roboshop.log
rm -rf frontend-main README.md >/tmp/roboshop.log
statusCheck $?

echo "copying robshop nginx config"
mv localhost.conf /etc/nginx/default.d/roboshop.conf >/tmp/roboshop.log
statusCheck $?

echo "Start nginx service"
systemctl enable nginx >/tmp/roboshop.log
systemctl restart nginx >/tmp/roboshop.log
statusCheck $?
