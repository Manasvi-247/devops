#!/bin/bash

CURRENT_DATE=$(date)
HOST_NAME=$(hostname)
USER_NAME=$(whoami)

echo "=============================="
echo "     SYSTEM INFORMATION"
echo "=============================="

echo "Date      : $CURRENT_DATE"
echo "Hostname  : $HOST_NAME"
echo "Username  : $USER_NAME"

echo
echo "------ Disk Usage ------"
df -h

echo
echo "------ Running Processes (top 10) ------"
ps aux | head -10

echo
read -p "Enter a directory name to create: " DIR_NAME
read -p "Enter a file name to create inside it: " FILE_NAME

mkdir -p "$DIR_NAME"
echo "Directory created: $DIR_NAME"

touch "$DIR_NAME/$FILE_NAME"
echo "File created: $DIR_NAME/$FILE_NAME"

ps aux > "$DIR_NAME/$FILE_NAME"
echo "Running process list saved to $DIR_NAME/$FILE_NAME"

echo
echo "------ First 5 lines of $DIR_NAME/$FILE_NAME ------"
head -5 "$DIR_NAME/$FILE_NAME"

echo
echo "Line count in file: $(wc -l < "$DIR_NAME/$FILE_NAME")"
echo "Script finished."
