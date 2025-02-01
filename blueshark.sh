#!/bin/bash

#Function definitions
function block_outbound(){
  echo "UFW Blocking Outbond Traffic:"
  read -p "Enter IP address: " ip_address
  read -p "Enter port: " port
  ufw deny out to $ip_address port $port
}
function list_rules(){
  echo "Listing Firewall Rules"
  ufw status numbered
}
function block_inbound(){
  echo "UFW blocking Inbound Traffic:"
  read -p "Enter IP address: " ip_address
  read -p "Enter port: " port
  
  ufw deny from $ip_address to any port $port
}
function delete_rule(){
  echo "UFW delete a rule:"
  read -p "Enter the rule number: " number
  ufw delete $number
}
function kill_process(){
  read -p "Enter the process name or PID to Kill: " process
  if [[ $process =~ ^[0-9]+$ ]]; then
	kill -9 $process
	echo "Process with PID $process has been killed"
  else
	echo  "Please enter a number for PID"
  fi
}
function  port_scan(){
  # Get the IP address of the computer
  IP=$(hostname -I | awk '{print $1}')
  #Define the range of ports to scan
  START_PORT=1
  END_PORT=1024

  echo "Scanning ports on $IP from $START_PORT to $END_PORT..."

  #Scan the ports
  for ((port=$START_PORT; port<=$END_PORT; port++))
  do
      (echo >/dev/tcp/$IP/$port) >/dev/null 2>&1 && echo "Port $port is open"
  done

  echo "Scan complete."
}
function check_connections(){
	read -p "Enter IP Address: " ip_add
	read -p "Enter State to Seach: " state
	
	if [ "$ip_add" == "*" ] && [ "$state" == "E" ]; then
	   netstat -anp | grep -E 'tcp|upd' | grep 'ESTABLISHED'
	elif [ "$ip_add" == "*" ] && [ "$state" == "*" ]; then
	   netstat -anp | grep -E 'tcp|udp'
	else
	   netstat -anp | grep -E 'tcp|upd' | grep "$ip_add" | grep "$state"
	fi
}

#Menu function
function show_menu(){
  echo "Choose an option:"
  echo "1) UFW Deny Outbound (<-)"
  echo "2) List Firewall Rules"
  echo "3) UFW Deny Inbound (->)"
  echo "4) Delete UFW rule (x)"
  echo "5) Kill process PID"
  echo "6) Port Scan"
  echo "7) tcp connections"
  echo "8) Exit"
}

# Main script logic
while true; do
  show_menu
  read -p "Enter your choice: " choice
  case $choice in
      1)
         block_outbound
	 ;;
      2)
   	 list_rules
	 ;;
      3)
	 block_inbound
	 ;;
      4)
	 delete_rule
	 ;;
      5)
         kill_process
         ;;
      6)
         port_scan
         ;;
      7)
	 check_connections
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
