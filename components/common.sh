checkRootUser(){
  USER_ID=$(id -u)

  if [ "$USER_ID" -ne 0 ]
  then
    echo Your suppose to be run this as a Root or Sudo user
    exit
  fi
}

statusCheck(){
  if [ $1 -eq 0 ]
  then
    echo -e "\e[32mSuccess\e[0m"
    else
      echo -e "\e[31sFail\e[0m"
      echo Check the error log in ${LOG_FILE}
      exit 1
      fi
}

LOG_FILE=/tmp/roboshop.log
rm -f $LOG_FILE

ECHO(){
  echo -e ".................$1................\n" >>${LOG_FILE}
  echo "$1"
}