checkRootUser(){
  USER_ID=$(id -u)

  if [ "$USER_ID" -ne 0 ]
  then
    echo Your suppose to be run this as a Root or Sudo user
  else
    exit

  fi
}

