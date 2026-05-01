#!/bin/bash

LOG_FILE="./update.log"

if [ "$EUID" -ne 0 ]; then
  echo "Please run with sudo"
  exit
fi

echo "===================================" | tee -a $LOG_FILE
echo "Update started at $(date)" | tee -a $LOG_FILE

echo "Updating package list..." | tee -a $LOG_FILE
apt update -y >> $LOG_FILE 2>&1

echo "Installing required packages..." | tee -a $LOG_FILE
apt install -y openjdk-17-jdk maven python3 python3-pip nginx git >> $LOG_FILE 2>&1

echo "Upgrading important packages..." | tee -a $LOG_FILE
apt install --only-upgrade -y openjdk-17-jdk maven python3 nginx >> $LOG_FILE 2>&1

echo "Starting nginx..." | tee -a $LOG_FILE
systemctl start nginx
systemctl enable nginx

echo "Installed Versions:" | tee -a $LOG_FILE
java -version 2>&1 | tee -a $LOG_FILE
mvn -version 2>&1 | tee -a $LOG_FILE
python3 --version | tee -a $LOG_FILE
nginx -v 2>&1 | tee -a $LOG_FILE
git --version | tee -a $LOG_FILE

echo "Update completed at $(date)" | tee -a $LOG_FILE
echo "===================================" | tee -a $LOG_FILE
