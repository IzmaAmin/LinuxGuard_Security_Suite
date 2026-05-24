#!/bin/bash

clear
figlet "Network Monitor" | lolcat
echo "======================================"
echo "      Network Monitoring Module"
echo "======================================"
echo
echo -e "\e[34m[NETWORK]\e[0m Detecting Open Ports..."
echo

ss -tuln
echo
echo "[+] Active Network Connections..."
echo

netstat -antp 2>/dev/null
echo
echo "[+] Listening Services..."
echo

ss -lntp
echo
echo "[+] Established Connections..."
echo

netstat -ant 2>/dev/null | grep ESTABLISHED
echo
echo "======================================"
echo " NETWORK SECURITY ANALYSIS"
echo "======================================"

open_ports=$(ss -tuln | grep LISTEN | wc -l)

echo "Total Listening Ports: $open_ports"
if [ $open_ports -gt 20 ]
then
    echo -e "\e[31m[HIGH ALERT]\e[0m Too Many Open Ports Detected"

elif [ $open_ports -gt 10 ]
then
    echo -e "\e[33m[MEDIUM ALERT]\e[0m Moderate Number of Open Ports"

else
    echo -e "\e[32m[LOW ALERT]\e[0m Network Exposure Appears Normal"
fi
ss -tuln > reports/open_ports_report.txt

netstat -antp 2>/dev/null > reports/network_connections_report.txt
echo
echo "======================================"
echo " Network Monitoring Completed"
echo " Reports saved in /reports directory"
echo "======================================"

echo
read -p "Press ENTER to return to dashboard..."
./main.sh

