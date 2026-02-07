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
    exit 1
  }

  log(){
    echo -e "$(date "+%Y-%m-%d %H:%M:%S") | $1" | tee -a $LOGS_FILE
  }

  if [ $# -lt 2 ]; then
    USAGE
    fi


if [ ! -d $SOURCE_DIR ]; then
    echo -e "$R source directory: $SOURCE_DIR does not exist $N"
    exit 1
fi

if [ ! -d $DEST_DIR ]; then
    echo -e "$R Destination directory:$DEST_DIR does not exist $N"
    exit 1
fi

### Find the files
FILES=$(find $SOURCE_DIR -name "*.log" -type f -mtime +$DAYS)

log "Backup started"
log "Source Directory: $SOURCE_DIR"
log "Destination Directory: $DEST_DIR"
log "Days: $DAYS"
 
if [ -z "${FILES}" ]; then
      log  "No files to archieve ... $Y Skipping $N"
  else
  # app-logs-$timestamp.zip
  log "Files found to archieve: $FILES"
  TIMESTAMP=$(date +%F-%H-%M-%S)
  ZIP_FILE_NAME="$DEST_DIR/app-logs-$TIMESTAMP.tar.gz"
  echo "Archeive name: $ZIP_FILE_NAME"
  tar -zcvf $ZIP_FILE_NAME $(find $SOURCE_DIR -name "*.log" -type f -mtime +$DAYS)

  #check archieve is success or not
  if [ -f $ZIP_FILE_NAME ]; then
     log "Archeival is ... $G SUCCESS $N"

     while IFS= read -r filepath; do
     # Process each line here
     echo "Deleting file: $filepath"
     rm -f $filepath
     echo "Deleted file: $filepath"
     done <<< $FILES
     else
     log "Archeival is ... $R FAILURE $N"
     exit 1
   fi


fi

