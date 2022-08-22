#!/usr/bin/env bash
#Running Roboshop Frontend with Sudo permission

source components/common.sh
#sample running frontend
checkRootUser

ECHO "installing nginx"
yum install nginx -y >>${LOG_FILE}
statusCheck $?

ECHO "downloading frontend code"
curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip" >>${LOG_FILE}
statusCheck $?
cd /usr/share/nginx/html

ECHO "removing old files"
rm -rf * >>${LOG_FILE}
statusCheck $?

ECHO "extracting zip content"
unzip /tmp/frontend.zip >>${LOG_FILE}
statusCheck $?

ECHO "copying extracted content"
mv frontend-main/* . >>${LOG_FILE} && mv static/* . >>${LOG_FILE} && rm -rf frontend-main README.md >>${LOG_FILE}
statusCheck $?

ECHO "copying robshop nginx config"
mv localhost.conf /etc/nginx/default.d/roboshop.conf >>${LOG_FILE}
statusCheck $?

ECHO "Update Nginx Configuration"
for component in catalogue user cart shipping payment ; do
  ECHO "Update Configuration for ${component}"
  sed -i -e "/${component}/ s/localhost/${component}.roboshop.internal/"  /etc/nginx/default.d/roboshop.conf
  statusCheck $?
done

ECHO "Start nginx service"
systemctl enable nginx >>${LOG_FILE} && systemctl restart nginx >>${LOG_FILE}
statusCheck $?
#echo test print