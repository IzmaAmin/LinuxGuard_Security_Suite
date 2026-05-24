#!/bin/bash
clear

echo "======================================"
echo "      LinuxGuard Installer"
echo "======================================"
echo
if [ "$EUID" -ne 0 ]
then
    echo "[ERROR] Please run installer as root"
    echo "Use: sudo ./install.sh"
    exit
fi
echo "Initializing Installer..."

sleep 2
echo
echo "[+] Updating Package Repositories..."

apt update -y
echo
echo "[+] Installing Dependencies..."

apt install figlet lolcat boxes net-tools iproute2 gawk iptables zip tree -y
gem install lolcat
echo
echo "[+] Creating Project Directories..."

mkdir -p reports
mkdir -p logs
mkdir -p screenshots
mkdir -p config
mkdir -p database
echo
echo "[+] Configuring Permissions..."

chmod +x main.sh
chmod +x splash.sh
chmod +x modules/*.sh
echo
echo "[+] Initializing Logs..."

touch logs/activity.log
echo "$(date) - LinuxGuard Installed" >> logs/activity.log
echo
echo "[+] Creating Default Configuration..."

touch config/settings.conf
echo
echo "======================================"
echo " LinuxGuard Installed Successfully"
echo "======================================"
echo
echo "To Start LinuxGuard:"
echo
echo "sudo ./main.sh"
echo
figlet "INSTALL COMPLETE" | lolcat

