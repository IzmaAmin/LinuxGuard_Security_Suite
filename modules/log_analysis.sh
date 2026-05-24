#!/bin/bash

clear
figlet "Network Monitor" | lolcat
echo "======================================"
echo "     Log Analysis & IDS Module"
echo "======================================"
echo
echo "[+] Detecting Failed Login Attempts..."
echo

grep "Failed password" /var/log/auth.log 2>/dev/null
echo
echo "[+] Total Failed Login Attempts:"

grep "Failed password" /var/log/auth.log 2>/dev/null | wc -l
echo
echo "[+] Root Login Attempts:"
echo

grep "root" /var/log/auth.log 2>/dev/null
echo
echo "[+] Successful Login Events:"
echo

grep "Accepted password" /var/log/auth.log 2>/dev/null
echo
echo "[+] Suspicious IPs (Failed Attempts):"
echo

grep "Failed password" /var/log/auth.log 2>/dev/null | awk '{print $(NF-3)}' | sort | uniq -c
echo
echo "======================================"
echo " SECURITY ANALYSIS"
echo "======================================"

count=$(grep "Failed password" /var/log/auth.log 2>/dev/null | wc -l)

if [ $count -gt 20 ]
then
    echo -e "\e[31m[HIGH ALERT]\e[0m Possible Brute Force Attack Detected"
elif [ $count -gt 5 ]
then
    echo -e "\e[33m[MEDIUM ALERT]\e[0m Suspicious Login Activity"
else
    echo -e "\e[32m[LOW ALERT]\e[0m System Normal"
fi
grep "Failed password" /var/log/auth.log > reports/failed_logins.txt

grep "Accepted password" /var/log/auth.log > reports/successful_logins.txt
echo
echo "======================================"
echo " Log Analysis Completed"
echo " Reports saved in /reports directory"
echo "======================================"

echo
read -p "Press ENTER to return to dashboard..."
./main.sh
