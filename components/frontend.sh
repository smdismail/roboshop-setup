#!/usr/bin/env bash
#Running Roboshop Frontend with Sudo permission

source components/common.sh

checkRootUser

yum install nginx -y >/tmp/roboshop.log
systemctl enable nginx >/tmp/roboshop.log
curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip" >/tmp/roboshop.log
cd /usr/share/nginx/html
rm -rf * >/tmp/roboshop.log
unzip /tmp/frontend.zip >/tmp/roboshop.log
mv frontend-main/static/* . >/tmp/roboshop.log
mv frontend-main/localhost.conf /etc/nginx/default.d/roboshop.conf >/tmp/roboshop.log
systemctl restart nginx >/tmp/roboshop.log

