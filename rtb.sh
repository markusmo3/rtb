#! /bin/bash

######################CONFIG SECTION###########################################
#
##Path to the FTB jar file with no trailing slash:
server_path="/root/ftb"
## Time to wait between backups. (In seconds)
## Default is 14400 (4 hours)
backup_interval=14400
## FTB Server start command.  Leave the trailing
server_start="java -Xms512M -Xmx4G -jar ${server_path}/FTB-Beta-A.jar"
###############################################################################

function ftbmon() {
  sleep 55
  while [[ 1 ]]
   do
    if [[ "$(ps faux | grep FTB-Beta-A.jar|grep -v grep)" == "" ]]
     then echo -e "$(date) -- \e[0;31mServer NOT running...\e[0m  \e[0;33mAttempting to start.\e[0m"
      $server_start & 
      sleep 55
    fi
    sleep 5
    epoch_time=$(date +%s)
    last_backup="$(stat -c %X $(find ${server_path}/backup/ -type f -mtime -1 -iname "backup*.zip"|grep $(date +%b)|sort|tail -n 1) 2>/dev/null)"
    [[ -z $last_backup ]] && last_backup=1 ## 1 second epoch time to force a backup if none exists.
    backup_time_diff=$(($epoch_time - $last_backup))
    if [[ $backup_time_diff -gt $backup_interval ]] 
    then 
      echo -e "$(date) -- \e[1;32mCreating a server backup:\e[0;32m Time since last backup: $backup_time_diff seconds ($(($backup_time_diff/60)) minutes) ($(($backup_time_diff/60/60)) hours)\e[0m"
      backup_path="${server_path}/backup/backup-$(date +%H-%M-%S_%d-%b-%Y).zip"
      zip -r $backup_path ${server_path} &> /dev/null
      echo -e "$(date) -- \e[0;32mBacked Up Server files to\e[1;32m $backup_path \e[0m"
    fi
  done
}

ftbmon &
$server_start
