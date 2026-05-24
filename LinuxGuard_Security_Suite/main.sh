#!/bin/bash
#!/bin/bash

clear
clear

figlet "LinuxGuard" | lolcat

echo "==========================================" | lolcat
echo "   Advanced Linux Security Monitoring" | lolcat
echo "==========================================" | lolcat

echo
echo -n "Initializing LinuxGuard"

for i in {1..5}
do
    echo -n "."
    sleep 0.3
done

echo
sleep 1
echo -e "\e[32m[STATUS]\e[0m System Active"
echo -e "\e[32m[USER]\e[0m $(whoami)"
echo -e "\e[32m[TIME]\e[0m $(date)"
echo
echo -e "\e[34m1)\e[0m File Permission Audit"
echo -e "\e[34m2)\e[0m Log Analysis & IDS"
echo -e "\e[34m3)\e[0m Network Monitoring"
echo -e "\e[34m4)\e[0m Process Monitoring"
echo -e "\e[34m5)\e[0m Real-Time Monitoring"
echo -e "\e[34m6)\e[0m IP Blocking System"
echo -e "\e[34m7)\e[0m Generate Security Report"
echo -e "\e[31m8)\e[0m Exit"
echo 
echo -ne "\e[33mSelect Option:\e[0m "
read option
case $option in

1)
bash modules/permission_audit.sh
;;

2)
bash modules/log_analysis.sh
;;

3)
bash modules/network_monitor.sh
;;

4)
bash modules/process_monitor.sh
;;

5)
bash modules/live_monitor.sh
;;

6)
bash modules/ip_blocker.sh
;;

7)
bash modules/report_manager.sh
;;

8)
echo
echo "Shutting Down LinuxGuard..." | lolcat

sleep 1

echo "Goodbye." | lolcat

sleep 1

clear
exit
;;

*)
echo -e "\e[31m[ERROR]\e[0m Invalid Option Selected"
sleep 2
;;

esac
