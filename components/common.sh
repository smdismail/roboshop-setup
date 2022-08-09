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
      echo -e "\e[31mFail\[0m"
      exit 1
      fi
}