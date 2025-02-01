#!/bin/bash

# Variables
BACKUP_DIR="/backup"
WEB_DIR="/var/www/html"
DB_NAME="your_database_name"
DB_USER="your_database_user"
DB_PASS="your_database_password"
DATE="202301311200"  # Replace with the actual date of the backup you want to restore

# Restore website files
tar -xzf $BACKUP_DIR/website_files_$DATE.tar.gz -C $WEB_DIR

# Restore MySQL database
mysql -u $DB_USER -p$DB_PASS $DB_NAME < $BACKUP_DIR/db_backup_$DATE.sql

# Print completion message
echo "Restore completed successfully. Website files and database have been restored from $BACKUP_DIR"