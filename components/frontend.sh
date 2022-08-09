#!/usr/bin/env bash
#Running Roboshop Frontend with Sudo permission

source components/common.sh

checkRootUser

echo "installing nginx"
yum install nginx -y >/tmp/roboshop.log


echo "downloading frontend code"
curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip" >/tmp/roboshop.log

cd /usr/share/nginx/html

echo "removing old files"
rm -rf * >/tmp/roboshop.log

echo "extracting zip content"
unzip /tmp/frontend.zip >/tmp/roboshop.log

echo "copying extracted content"
mv frontend-main/* . >/tmp/roboshop.log
mv static/* . >/tmp/roboshop.log
rm -rf frontend-main README.md >/tmp/roboshop.log

echo "copying extracted content"
mv localhost.conf /etc/nginx/default.d/roboshop.conf >/tmp/roboshop.log

echo "Start nginx service"
systemctl enable nginx >/tmp/roboshop.log
systemctl restart nginx >/tmp/roboshop.log

