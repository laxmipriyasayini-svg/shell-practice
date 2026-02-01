#!/bin/bash

USERID=$(id -u)
LOGS_FOLDER="/var/log/shell-script"
LOGS_FILE="/var/log/shell-script/$0.log"

if [ $UERID -ne 0 ]; then
echo "please run this script with root user access" | tee -a $LOGS_FILE
exit 1
fi

mkdir -p $LOGS_FOLDER

VALIDATE(){
    if [ $1 -ne 0 ]; then
    echo "$2...FAILURE" | tee -a $LOGS_FILE
    exit 1
    else
    echo "$2...SUCCESS" | tee -a $LOGS_FILE
    fi
}

for package in $@
do
   dnf install $package -y
   VALIDATE $? "$package installation"
   done 