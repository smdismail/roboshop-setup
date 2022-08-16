#!/usr/bin/env bash

source components/common.sh
checkRootUser

#curl -s -o /etc/yum.repos.d/mongodb.repo https://raw.githubusercontent.com/roboshop-devops-project/mongodb/main/mongo.repo
#ECHO "installing mongodb"

#yum install -y mongodb-org
#systemctl enable mongod
#systemctl start mongod

#update /etc/mongod.conf
#systemctl restart mongod

#curl -s -L -o /tmp/mongodb.zip "https://github.com/roboshop-devops-project/mongodb/archive/main.zip"

# cd /tmp
# unzip mongodb.zip
# cd mongodb-main
# mongo < catalogue.js
# mongo < users.js

ECHO "Setup mongodb yum repo"
curl -s -o /etc/yum.repos.d/mongodb.repo https://raw.githubusercontent.com/roboshop-devops-project/mongodb/main/mongo.repo >>${LOG_FILE}
statusCheck $?

ECHO "Installing Mongodb"
yum install -y mongodb-org >>${LOG_FILE}
statusCheck $?

#update /etc/mongod.conf
ECHO "Configure Listen address in Mongodb configuration"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf
statusCheck $?

ECHO "Restart Mongodb Service"
systemctl restart mongod >>${LOG_FILE} && systemctl enable mongod >>${LOG_FILE}
statusCheck $?

ECHO "Download Schema"
curl -s -L -o /tmp/mongodb.zip "https://github.com/roboshop-devops-project/mongodb/archive/main.zip" >>${LOG_FILE}
statusCheck $?

ECHO "Extract schema Zip file"
cd /tmp && unzip -o mongodb.zip >>${LOG_FILE}
statusCheck $?

ECHO "Load Schema"
cd mongodb-main && mongo < catalogue.js >>${LOG_FILE} && mongo < users.js >>${LOG_FILE}
statusCheck $?

