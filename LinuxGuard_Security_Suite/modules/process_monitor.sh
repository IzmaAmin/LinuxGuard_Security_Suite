#!/bin/bash

clear
figlet "Network Monitor" | lolcat
echo "======================================"
echo "      Process Monitoring Module"
echo "======================================"
echo
echo -e "\e[34m[PROCESS]\e[0m Top CPU Consuming Processes..."
echo

ps aux --sort=-%cpu | head -10
echo
echo "[+] Top Memory Consuming Processes..."
echo

ps aux --sort=-%mem | head -10
echo
echo "[+] Active Running Processes..."
echo

ps -ef | head -20
echo
echo "======================================"
echo " PROCESS SECURITY ANALYSIS"
echo "======================================"

high_cpu=$(ps aux --sort=-%cpu | awk 'NR==2 {print int($3)}')

echo "Highest CPU Usage Detected: $high_cpu%"
if [ $high_cpu -gt 80 ]
then
    echo -e "\e[31m[HIGH ALERT]\e[0m Suspicious High CPU Activity"

elif [ $high_cpu -gt 40 ]
then
    echo -e "\e[33m[MEDIUM ALERT]\e[0m Moderate CPU Consumption"

else
    echo -e "\e[32m[LOW ALERT]\e[0m CPU Usage Appears Normal"
fi
ps aux --sort=-%cpu > reports/cpu_process_report.txt

ps aux --sort=-%mem > reports/memory_process_report.txt
echo
echo "[+] System Load Information..."
echo

uptime
echo
echo "[+] Memory Usage Information..."
echo

free -h
echo
echo "======================================"
echo " Process Monitoring Completed"
echo " Reports saved in /reports directory"
echo "======================================"

echo
read -p "Press ENTER to return to dashboard..."
./main.sh

