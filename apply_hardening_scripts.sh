pip3 install ansible
cd /ansible/ ; ansible-playbook site.yml
chmod 750 /etc/sudoers.d
echo "Legal Banner : Attention, by continuing to connect to this system, you consent to the owner storing a log of all activity. Unauthorized access is prohibited." > /etc/issue 
echo "Legal Banner : Attention, by continuing to connect to this system, you consent to the owner storing a log of all activity. Unauthorized access is prohibited." > /etc/issue.net
echo "kernel.sysrq = 0" >> /etc/sysctl.conf
echo "dev.tty.ldisc_autoload = 0" >> /etc/sysctl.conf
echo "fs.protected_fifos = 2" >> /etc/sysctl.conf
echo "fs.protected_regular = 2" >> /etc/sysctl.conf
echo "kernel.modules_disabled = 1" >> /etc/sysctl.conf
echo "kernel.core_uses_pid = 1" >> /etc/sysctl.conf
sysctl -p
apt-get install suricata -y
service suricata start
