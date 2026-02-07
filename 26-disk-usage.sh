#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

log(){
    echo -e "$(date "+%Y-%m-%d %H:%M:%S") | $1" | tee -a $LOGS_FILE
  }

  DISK_USAGE=$(df -hT | grep -v Filesystem)
  USAGE_THRESHOLD=3

  while IFS= read -r line; do
     USAGE=$($line | awk '{print $6}' | cut -d "%" -f1)
     PARTITION=$($line | awk '{print $7}')

  if [ $USAGE -gt $USAGE_THRESHOLD ]; then
     MESSAGE+="High Disk usage on $PARTITION:$USAGE"
  fi

  # done <<< $DISK_USAGE
  done <<< $DISK_USAGE

  echo "$MESSAGE"