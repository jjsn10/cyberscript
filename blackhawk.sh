#!/bin/bash

#Output file for SSH connections
OUTPUT_FILE="$HOME/ssh_connections.log"

#Ensure the output file exists
touch "$OUTPUT_FILE"

#Function
monitor_ssh(){
  journalctl -u sshd -f | while read line; do
	if echo "$line" | grep -q "sshd.*Accepted"; then
	   echo "$(date): $line" >> "$OUTPUT_FILE"
	fi
  done
}

# Run the monitor function in the background
monitor_ssh &
echo "SSH monitoring started. Logging to $OUTPUT_FILE"
