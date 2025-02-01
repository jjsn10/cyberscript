#!/bin/bash

# Variables
BACKUP_DIR="/path/to/backup/directory"
SITE_DIR="/path/to/prestashop"
DB_NAME="your_db_name"
DB_USER="your_db_user"
DB_PASS="your_db_password"
BACKUP_DATE="202201010000"  # Replace with the date of the backup you want to restore

# Restore site files
tar -xzf $BACKUP_DIR/prestashop_files_$BACKUP_DATE.tar.gz -C $SITE_DIR

# Restore database
gunzip < $BACKUP_DIR/prestashop_db_$BACKUP_DATE.sql.gz | mysql -u $DB_USER -p$DB_PASS $DB_NAME

echo "Restore completed successfully!"