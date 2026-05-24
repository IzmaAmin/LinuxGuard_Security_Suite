#!/bin/bash

clear
figlet "Network Monitor" | lolcat
echo "======================================"
echo "     LinuxGuard Reporting System"
echo "======================================"
echo

# Create reports folder if missing
mkdir -p reports

# Generate timestamp
timestamp=$(date +"%Y-%m-%d_%H-%M-%S")

# Create report filename
report_file="reports/security_report_${timestamp}.txt"

# Start report
echo "LinuxGuard Security Report" > "$report_file"
echo "Generated on: $(date)" >> "$report_file"
echo "======================================" >> "$report_file"
echo "" >> "$report_file"

# System Information
echo "[SYSTEM INFORMATION]" >> "$report_file"
uname -a >> "$report_file"
echo "" >> "$report_file"

# Current User
echo "[CURRENT USER]" >> "$report_file"
whoami >> "$report_file"
echo "" >> "$report_file"

# Failed Login Attempts
echo "[FAILED LOGIN ATTEMPTS]" >> "$report_file"
grep "Failed password" /var/log/auth.log 2>/dev/null >> "$report_file"
echo "" >> "$report_file"

# Open Ports
echo "[OPEN PORTS]" >> "$report_file"
ss -tuln >> "$report_file"
echo "" >> "$report_file"

# Top CPU Processes
echo "[TOP CPU PROCESSES]" >> "$report_file"
ps aux --sort=-%cpu | head -10 >> "$report_file"
echo "" >> "$report_file"

# SUID Files
echo "[SUID FILES]" >> "$report_file"
find / -perm -4000 2>/dev/null >> "$report_file"
echo "" >> "$report_file"

# Security Analysis
failed_attempts=$(grep "Failed password" /var/log/auth.log 2>/dev/null | wc -l)

echo "[SECURITY STATUS]" >> "$report_file"

if [ "$failed_attempts" -gt 20 ]
then
    echo "HIGH ALERT - Possible Intrusion Detected" >> "$report_file"

elif [ "$failed_attempts" -gt 5 ]
then
    echo "MEDIUM ALERT - Suspicious Activity Detected" >> "$report_file"

else
    echo "LOW ALERT - System Appears Stable" >> "$report_file"
fi

echo "" >> "$report_file"

# End Report
echo "======================================" >> "$report_file"
echo "End of LinuxGuard Report" >> "$report_file"

# Display Success Message
echo
echo -e "\e[32m[REPORT GENERATED SUCCESSFULLY]\e[0m"
echo
echo "Saved Report:"
echo "$report_file"
echo

# Optional log entry
echo "$(date) - Security Report Generated" >> logs/activity.log

echo
read -p "Press ENTER to return to dashboard..."
./main.sh
