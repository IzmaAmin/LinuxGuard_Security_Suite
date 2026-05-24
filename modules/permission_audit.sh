#!/bin/bash
clear
figlet "Network Monitor" | lolcat

echo "======================================"
echo "   File Permission Audit Module"
echo "======================================"
echo
echo -e "\e[31m[HIGH]\e[0m Scanning World Writable Files..."
echo

find / -type f -perm -0002 2>/dev/null
echo
echo "[+] Scanning 777 Permission Files..."
echo

find / -type f -perm 0777 2>/dev/null
echo
echo "[+] Scanning SUID Files..."
echo

find / -perm -4000 2>/dev/null
echo
echo "[+] Scanning SGID Files..."
echo

count=$(find / -type f -perm -0002 2>/dev/null | wc -l)

echo
echo "Total World Writable Files Found: $count"

find / -perm -2000 2>/dev/null

find / -type f -perm -0002 2>/dev/null > reports/world_writable_report.txt

find / -perm -4000 2>/dev/null > reports/suid_report.txt
echo
echo "======================================"
echo " Permission Audit Completed"
echo "======================================"
echo
read -p "Press ENTER to return to dashboard..."
./main.sh
