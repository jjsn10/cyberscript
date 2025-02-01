#!/bin/bash

# Variables
BACKUP_DIR="/path/to/backup/directory"
SITE_DIR="/path/to/prestashop"
DB_NAME="your_db_name"
DB_USER="your_db_user"
DB_PASS="your_db_password"
DATE=$(date +"%Y%m%d%H%M")

# Create backup directory if it doesn't exist
mkdir -p $BACKUP_DIR

# Backup site files
tar -czf $BACKUP_DIR/prestashop_files_$DATE.tar.gz -C $SITE_DIR .

# Backup database
mysqldump -u $DB_USER -p$DB_PASS $DB_NAME > $BACKUP_DIR/prestashop_db_$DATE.sql

# Compress database backup
gzip $BACKUP_DIR/prestashop_db_$DATE.sql

echo "Backup completed successfully!"