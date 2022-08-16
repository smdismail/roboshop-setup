#!/usr/bin/env bash

source components/common.sh
checkRootUser

## curl -sL https://rpm.nodesource.com/setup_lts.x | bash
## yum install nodejs -y
#
## useradd roboshop
#
#$ curl -s -L -o /tmp/catalogue.zip "https://github.com/roboshop-devops-project/catalogue/archive/main.zip"
#$ cd /home/roboshop
#$ unzip /tmp/catalogue.zip
#$ mv catalogue-main catalogue
#$ cd /home/roboshop/catalogue
#$ npm install
#
#   Update `MONGO_DNSNAME` with MongoDB Server IP
#
## mv /home/roboshop/catalogue/systemd.service /etc/systemd/system/catalogue.service
## systemctl daemon-reload
## systemctl start catalogue
## systemctl enable catalogue


ECHO "Configure Nodjs Setup"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash >>${LOG_FILE}
statusCheck $?

ECHO "Installing NodeJs"
yum install nodejs gcc-c++ -y >>${LOG_FILE}
statusCheck $?


id roboshop >>${LOG_FILE}
if [ $? -ne 0 ];
then
  ECHO "Application User add"
  useradd roboshop >>${LOG_FILE}
  fi
statusCheck $?











