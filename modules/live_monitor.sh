#!/bin/bash
while true
do
clear
figlet "Network Monitor" | lolcat
echo "======================================"
echo "     LinuxGuard Live Monitor"
echo "======================================"
echo
echo "[TIME]"
date
echo
echo -e "\e[34m[LIVE LOGIN ALERTS]\e[0m"
grep "Failed password" /var/log/auth.log 2>/dev/null | tail -5
echo
echo "[LIVE NETWORK PORTS]"
ss -tuln | head
echo
echo "[TOP CPU PROCESSES]"
ps aux --sort=-%cpu | head -5
echo
echo "[MEMORY STATUS]"
free -h
echo
echo "[SYSTEM LOAD]"
uptime
echo
failed_attempts=$(grep "Failed password" /var/log/auth.log 2>/dev/null | wc -l)

echo "[SECURITY STATUS]"

if [ $failed_attempts -gt 20 ]
then
    echo -e "\e[31m[HIGH ALERT]\e[0m Multiple Failed Login Attempts"

elif [ $failed_attempts -gt 5 ]
then
    echo -e "\e[33m[MEDIUM ALERT]\e[0m Suspicious Login Activity"

else
    echo -e "\e[32m[SYSTEM NORMAL]\e[0m No Major Threats Detected"
fi
echo
echo "Refreshing in 10 seconds..."
sleep 10
done

echo
read -p "Press ENTER to return to dashboard..."
./main.sh
