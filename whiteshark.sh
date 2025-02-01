#!/bin/bash

# Function to list firewall rules
list_rules() {
    sudo firewall-cmd --list-all
}

# Function to block inbound IP address and port
block_inbound() {
    read -p "Enter IP address to block: " ip
    read -p "Enter port to block: " port
    sudo firewall-cmd --permanent --add-rich-rule="rule family='ipv4' source address='$ip' port port='$port' protocol='tcp' reject"
    sudo firewall-cmd --reload
    echo "Inbound IP $ip and port $port blocked."
}

# Function to block outbound IP address and port
block_outbound() {
    read -p "Enter IP address to block: " ip
    read -p "Enter port to block: " port
    sudo firewall-cmd --permanent --add-rich-rule="rule family='ipv4' destination address='$ip' port port='$port' protocol='tcp' reject"
    sudo firewall-cmd --reload
    echo "Outbound IP $ip and port $port blocked."
}

# Function to delete a specific rule
delete_rule() {
    read -p "Enter the rule to delete (e.g., rule family='ipv4' source address='192.168.1.1' port port='80' protocol='tcp' reject): " rule
    sudo firewall-cmd --permanent --remove-rich-rule="$rule"
    sudo firewall-cmd --reload
    echo "Rule deleted."
}

# Function to reload the firewall
reload_firewall() {
    sudo firewall-cmd --reload
    echo "Firewall reloaded."
}

# Menu
while true; do
    echo "Choose an option:"
    echo "1. List firewall rules"
    echo "2. Block inbound IP address and port"
    echo "3. Block outbound IP address and port"
    echo "4. Delete specific rule"
    echo "5. Reload firewall"
    echo "6. Exit"
    read -p "Enter your choice: " choice

    case $choice in
        1) list_rules ;;
        2) block_inbound ;;
        3) block_outbound ;;
        4) delete_rule ;;
        5) reload_firewall ;;
        6) exit 0 ;;
        *) echo "Invalid option. Please try again." ;;
    esac
done