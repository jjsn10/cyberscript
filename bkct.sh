#!/bin/bash

# Variables
BACKUP_DIR="/backup"
WEB_DIR="/var/www/html"
DB_NAME="your_database_name"
DB_USER="your_database_user"
DB_PASS="your_database_password"
DATE=$(date +%Y%m%d%H%M)

# Create backup directory if it doesn't exist
mkdir -p $BACKUP_DIR

# Backup website files
tar -czf $BACKUP_DIR/website_files_$DATE.tar.gz $WEB_DIR

# Backup MySQL database
mysqldump -u $DB_USER -p$DB_PASS $DB_NAME > $BACKUP_DIR/db_backup_$DATE.sql

# Print completion message
echo "Backup completed successfully. Files are stored in $BACKUP_DIR"