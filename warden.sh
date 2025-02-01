```
#!/bin/bash

echo ""
echo "+------------------The Warden 2.0 is Now Online------------------+"
echo ""
echo "+--------This Script Monitors Various System Logs/Files------+"



echo -n "[> Enter audit interval (in seconds)]:"
read  time

#this takes the time variable and uses it to determine the refresh rate of the script
while sleep $time; do
        clear

        echo ""
        echo "+--------------------/Active Connections\-----------------------+"
        echo ""
        #I send it to connect_history so if we are not looking at the screen we will have it saved in a file to look at and we can also use that file to print out the last minute or minutes of connections
        sudo netstat -anop | egrep EST | awk ' { print $7,$6,$4,$5 } ' >> connect_history.txt

        #At 5 second interval with a average of 4 connects it will generate 48 lines in a minute
        #A 50 line tail will look at he last minute of connections
        tail -n 50 connect_history.txt | sort -u




        echo ""
        echo "+--------------------/var/log/auth.log-----------------------+"
        echo ""

        #grep will search a file and the -i switch will remove any case sensitivity. You can also search multiple values seperating them with '/|'
        #tail -n (number of lines)
        grep -i 'failed\|accepted' /var/log/auth.log | tail -n 7

        echo ""
        echo " +---------------/etc/passwd Users Valid Login's----------------+"
        echo ""
        #We are searching for login shells in the etc password awk -F : will break up the string on ':' and we are printing out the first and seventh break up
        grep -i '/bin/bash\|/bin/sh\|/bin/csh\|/sbin/sh\|/bin/ksh' /etc/passwd | awk -F : ' { print $1, $7 } '

        echo ""
        echo "+---------------File Integrity Management-----------------+"
        echo "This will report if the file has been modified with the last 10 min"
        echo ""

        echo "+-----------------------Cron Files--------------------------+"
        echo ""
        #This find command will search the spool dir the -type f denotes a file and -newermnt mean eddited within "time period"
        sudo find /var/spool -type f -newermt "-10 minutes"


        echo ""
        echo "+----------------New installed software----------------------+"
        #Now we are just searching if this file has been modified within the last 10 minutes
        sudo find /var/log/dpkg.log -type f -newermt "-10 minutes"


        echo ""
        echo "+----------------New Files Created"----------------------+
        sudo find / -maxdepth 7 -type d \( -path /proc -o -path /sys/dev/char -o -path /run/systemd/resolve -o -path /sys/kernel -o -path /sys/module -o -path /sys/devices -o -path /var/log/journal -o -path /sys/bus -o -path /run/systemd/netif \) -prune -false -o -newermt "-10 minutes"


done
```