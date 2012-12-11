#! /bin/bash

######################CONFIG SECTION###########################################
#
##Path to the FTB jar file with no trailing slash /
server_path="/root/ftb"
## FTB Server start command. (you can grab this from the .bat files)
server_start="java -Xms512M -Xmx4G -jar ${server_path}/FTB-Beta-A.jar"
##############Backup Options###################################################
## Time to wait between backups. (In seconds)
## Default is 14400 seconds (every 4 hours)
backup_interval=86400 # daily
## Backup location. No trailing slash /
backup_location="${server_path}/backup"
## Backup Retention in DAYS
backup_retention=15
####################Extended Backup Options####################################
use_extended_options=1 # 0=false, 1=true
keep_daily_backup=0 # Keep at least one backup from each day.
keep_weekly_backup=0 # Same for weekly backup.
keep_monthly_backup=0 # monthly
backup_time=00:00:00 # Timestamp for when backups should be made (roughly) HH:MM:SS
restart_after_backup=0 # restart server after performing a scheduled backup at the time above.
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
      [[ ! -d $backup_location ]] && mkdir -p $backup_location
      echo -e "$(date) -- \e[1;32mCreating a server backup:\e[0;32m Time since last backup: $backup_time_diff seconds ($(($backup_time_diff/60)) minutes) ($(($backup_time_diff/60/60)) hours)\e[0m"
      backup_file="${backup_location}/backup-$(date +%H-%M-%S_%d-%b-%Y).zip"
      zip -r "${backup_file}" "${server_path}" &> /dev/null
      echo -e "$(date) -- \e[0;32mBacked Up Server files to\e[1;32m ${backup_file} \e[0m"
      find ${backup_location} -type f -name "backup-*.zip" -mtime +${backup_retention} -exec rm -fv "{}" \;
    fi
    if [[ $use_extended_options = 1 ]]
     then extended_backup
    fi
  done
}

function extended_backup() {
  echo -e "Extended backups don't do anything yet. Not a damn thing."
}

ftbmon &
$server_start