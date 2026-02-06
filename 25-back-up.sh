#!/bin/bash

USERID=$(id -u)

LOGS_DIR="/var/log/shell-script"
LOGS_FILE="/var/log/shell-script/backup.log"
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
SOURCE_DIR=$1
DEST_DIR=$2
DAYS=${3:-14} # 14 days i the default valuve, if the user not supplied
if [ $USERID -ne 0 ]; then
   echo -e " $R Please run this script with root user access $N"
   exit 1
   fi

   mkdir -p $LOGS_DIR
  
  USAGE(){
    echo -e " $R USAGE:: sudo backup <SOURCE_DIR> <DEST_DIR> [default 14 days] $N"
  }

  if [ $# -lt 2 ]; then
    USAGE
    fi

if [ -d $SOURCE_DIR ]; then
    echo -e "$R $SOURCE_DIR does not exist $N"
    exit 1
fi

if [ -d $DEST_DIR ]; then
    echo -e "$R $DEST_DIR does not exist $N"
    exit 1
fi
