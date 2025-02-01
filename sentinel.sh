#!/bin/bash

# Path to the file where we store the last state of /etc/passwd
LAST_STATE="/var/tmp/last_passwd_state"

# Function to check for changes and print the modified or created user
check_users() {
    if [ ! -f "$LAST_STATE" ]; then
        cp /etc/passwd "$LAST_STATE"
        echo "Initial state saved."
        return
    fi

    # Compare the current state of /etc/passwd with the last saved state
    if ! cmp -s /etc/passwd "$LAST_STATE"; then
        echo "A new user has been created or a user has been modified."
        # Find the difference and print the complete information
        diff /etc/passwd "$LAST_STATE" | grep '>' | awk -F: '{print "User created or modified: " $0}'
        # Update the last state file with the current state
        cp /etc/passwd "$LAST_STATE"
    else
        echo "No new users have been created."
    fi
}

# Check if the interval is provided as an argument
if [ -z "$1" ]; then
    echo "Usage: $0 <interval_in_seconds>"
    exit 1
fi

INTERVAL=$5

# Run the check in an infinite loop with the specified interval
while true; do
    check_users
    sleep "$INTERVAL"
done