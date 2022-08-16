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

ECHO "Download application content"
curl -s -L -o /tmp/catalogue.zip "https://github.com/roboshop-devops-project/catalogue/archive/main.zip" >>${LOG_FILE}
statusCheck $?

ECHO "Extract application archive"
cd /home/roboshop && rm -rf catalogue >>${LOG_FILE} && unzip /tmp/catalogue.zip >>${LOG_FILE} && mv catalogue-main catalogue
statusCheck $?

ECHO "Install NodeJs module"
cd /home/roboshop/catalogue && npm install >>${LOG_FILE} && chown roboshop:roboshop /home/roboshop/catalogue -R
statusCheck $?

ECHO "Update SystemD configuration file"
sed -i -e 's/MONGO_DNSNAME/mongodb.roboshop.internal/' /home/roboshop/catalogue/systemd.service
statusCheck $?

ECHO "Update SystemD Service"
mv /home/roboshop/catalogue/systemd.service /etc/systemd/system/catalogue.service
systemctl daemon-reload >>${LOG_FILE} && systemctl enable catalogue >>${LOG_FILE} && systemctl restart catalogue >>${LOG_FILE}
statusCheck $?



