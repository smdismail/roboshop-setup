#!/usr/bin/env bash
#Running Roboshop Frontend with Sudo permission

USER_ID=$(id -u)

if [ "$USER_ID" -ne 0 ]
then
  echo Your suppose to be run this as a Root or Sudo user
else

yum install nginx -y
systemctl enable nginx
curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip"
cd /usr/share/nginx/html
rm -rf *
unzip /tmp/frontend.zip
mv frontend-main/static/* .
mv frontend-main/localhost.conf /etc/nginx/default.d/roboshop.conf
systemctl restart nginx

fi