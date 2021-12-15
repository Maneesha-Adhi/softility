# Loading required Hardending configurations
sysctl -p
service suricata start
# Running Lynis Scan
cd /lynis ; ./lynis audit system
# Convert lynis .dat report into json format
/lynis-report-converter/lynis-report-converter.pl -j -o /var/log/lynis-report.json -i /var/log/lynis-report.dat
