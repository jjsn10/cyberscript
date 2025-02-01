#!/bin/bash

function apache_logs(){
	#journalctl -u apache2
	read -p "Type of Log:(1: access, empty: error): " type_log
	if [ "$type_log" == "1" ] ; then
		less /var/log/apache2/access.log
	else
		less /var/log/apache2/error.log
	fi
}
function check_www_data(){
	read -p "Choose user: (1: Ubuntu, empty: CentOS): " os_type
	if [ "$os_type" == "1" ] ; then
		cat /etc/passwd | grep 'www-data'
	else
		cat /etc/passwd | grep 'apache'
	fi
}
function restore_www_data(){
	read -p "Choose user: (1: Ubuntu, empty: CentOS): " os_type
	if [ "$os_type" == "1" ] ; then
		usermod -s /usr/sbin/nologin www-data
	else
		usermod -s /usr/sbin/nologin apache
	fi
}
function check_apache_conf(){
	apachectl configtest
}
function list_sites(){
	ls -l /etc/apache2/sites-available/
}
function backup_conf_site(){
	read -p "Name of config Site: " name
	echo "Copying /etc/apache2/sites-available/$name to ~/$name.bak"
	cp /etc/apache2/sites-available/"$name" ~/"$name.bak"
}
function clear_console(){
	clear
}
#Menu function
function show_menu(){
	echo "Choose an option:"
	echo "1) Check Apache Logs-Ubuntu"
	echo "2) Check www_data User-Ubuntu/CentOS"
	echo "3) Restore www_data User-Ubuntu/CentOS"
	echo "4) Check Apache Config-Ubuntu/CentOS"
	echo "5) List Apache Sites Ubuntu"
	echo "6) Backup Config Site Ubuntu"
	echo "7) Clear Console"
	echo "8) Exit"
}

#Main script logic
while true; do
   show_menu
   read -p "Enter your choice: " choice
   case $choice in
	1) 
	  apache_logs
	  ;;
	2)
	  check_www_data
	  ;;
	3)
	  restore_www_data
	  ;;
	4)
	  check_apache_conf
	  ;;
	5)
	  list_sites
	  ;;
	6)
	  backup_conf_site
	  ;;
	7)
	  clear_console
	  ;;
	8)
	  echo "Exiting..."
	  break
	  ;;
	*)
	  echo "Invalid option, please try again."
	  ;;
    esac
done
