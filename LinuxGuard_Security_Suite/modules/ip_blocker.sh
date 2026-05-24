#!/bin/bash

clear

figlet "Network Monitor" | lolcat
echo "======================================"
echo "      IP Blocking Module"
echo "======================================"
echo
echo "[+] Suspicious IP Addresses:"
echo

grep "Failed password" /var/log/auth.log 2>/dev/null | awk '{print $(NF-3)}' | sort | uniq -c | sort -nr
echo
read -p "Enter IP Address to Block: " ip
if [ "$ip" = "127.0.0.1" ]
then
    echo "Cannot block localhost"
    exit
fi
if [ "$ip" = "192.168.148.150" ]
then
    echo "Cannot block localhost"
    exit
fi
if [ -z "$ip" ]
then
    echo "No IP Entered"
    exit
fi
sudo iptables -A INPUT -s $ip -j DROP
echo
echo -e "\e[31m[BLOCKED]\e[0m IP Address $ip has been blocked."
echo "$ip blocked on $(date)" >> reports/blocked_ips.txt
echo
echo "[+] Current Firewall Rules:"
echo

sudo iptables -L INPUT -n
echo
echo "======================================"
echo " Active Response Completed"
echo " Firewall Updated Successfully"
echo "======================================"

echo
read -p "Press ENTER to return to dashboard..."

./main.sh
