#!/bin/bash

# Configuration
SOURCE_DIR="/path/to/source"
BACKUP_DIR="/path/to/backup/destination"
REMOTE_SERVER="user@remote.server:/path/to/remote/backup"
LOG_FILE="/var/log/backup.log"
DATE=$(date +"%Y%m%d%H%M")

# Backup command
rsync -avz $SOURCE_DIR $REMOTE_SERVER >> $LOG_FILE 2>&1

# Check if the backup was successful
if [ $? -eq 0 ]; then
    echo "$(date): Backup successful" >> $LOG_FILE
else
    echo "$(date): Backup failed" >> $LOG_FILE
fi
