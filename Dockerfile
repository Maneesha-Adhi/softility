FROM ubuntu:18.04
ENV DEBIAN_FRONTEND noninteractive
ENV DEBIAN_FRONTEND teletype
Run apt-get update -y
## Lynis - Debian Tests solutions
Run apt-get install libpam-tmpdir -y
RUN apt-get install apt-listchanges -y
RUN apt-get install needrestart -y
RUN apt-get install debsecan -y
RUN apt-get install debsums -y
RUN apt-get install fail2ban -y
## Lynis - sysctl solutions
Run echo "fs.suid_dumpable = 0" >> /etc/sysctl.conf
Run echo "kernel.core_uses_pid = 1" >> /etc/sysctl.conf
Run echo "kernel.kptr_restrict = 2" >> /etc/sysctl.conf
Run echo "kernel.sysrq = 0" >> /etc/sysctl.conf
Run echo "net.ipv4.conf.all.forwarding = 0" >> /etc/sysctl.conf
Run echo "net.ipv4.conf.all.log_martians = 1" >> /etc/sysctl.conf
Run echo "net.ipv4.conf.all.send_redirects = 0" >> /etc/sysctl.conf
Run echo "net.ipv4.conf.default.accept_source_route = 0" >> /etc/sysctl.conf
Run echo "net.ipv4.conf.default.log_martians = 1" >> /etc/sysctl.conf
Run echo "net.ipv6.conf.all.accept_redirects = 0" >> /etc/sysctl.conf
Run echo "net.ipv6.conf.default.accept_redirects = 0" >> /etc/sysctl.conf
Run echo "net.ipv4.conf.all.accept_redirects = 0" >> /etc/sysctl.conf
Run echo "dev.tty.ldisc_autoload = 0" >> /etc/sysctl.conf
Run echo "fs.protected_fifos = 2" >> /etc/sysctl.conf
Run echo "fs.protected_regular = 2" >> /etc/sysctl.conf
Run echo "kernel.modules_disabled = 1" >> /etc/sysctl.conf
RUN echo "kernel.unprivileged_bpf_disabled = 1" >> /etc/sysctl.conf
## Lynis - Hardening Tests Solutions
RUN apt-get install rkhunter -y
##software : file integrity tests
RUN apt-get install aide -y
RUN aideinit
##software system tooling
RUN apt-get update
RUN apt-get install puppet -y
##File permissions
RUN cd /etc ; chmod 100 crontab
RUN cd /etc ; chmod -x cron.d
RUN cd /etc ; chmod -x cron.daily cron.hourly cron.monthly cron.weekly
## Shells
RUN apt-get install vim -y
RUN echo "umask 027" >> /etc/bash.bashrc 
RUN echo "umask 027" >> /etc/profile
RUN echo "TMOUT={{ ubuntu1804cis_shell_timeout }}" >> /etc/bash.bashrc
RUN echo "TMOUT={{ ubuntu1804cis_shell_timeout }}" >> /etc/profile
## security framework
RUN apt-get update
RUN apt-get install apparmor -y
##user, groups, and authentication
RUN echo "umask 027" >> /etc/login.defs
RUN echo "PASS_MAX_DAYS {{ ubuntu1804cis_pass['max_days'] }}" >> /etc/login.defs
RUN echo "PASS_MIN_DAYS {{ ubuntu1804cis_pass['min_days'] }}" >> /etc/login.defs
RUN apt-get install libpam-pwquality -y
##Accounting
RUN apt install sysstat -y
RUN systemctl enable sysstat
Run sysctl -p
Run apt-get install git -y
Run git clone -b 3.0.6 https://github.com/CISOfy/lynis.git
##Lynis Report Converter
RUN apt -y install htmldoc libxml-writer-perl libarchive-zip-perl libjson-perl
RUN pushd /tmp/
RUN wget http://search.cpan.org/CPAN/authors/id/M/MF/MFRANKL/HTML-HTMLDoc-0.10.tar.gz
RUN tar xvf HTML-HTMLDoc-0.10.tar.gz
RUN pushd HTML-HTMLDoc-0.10
RUN perl Makefile.PL
RUN make && make install
RUN popd
RUN wget http://search.cpan.org/CPAN/authors/id/J/JM/JMCNAMARA/Excel-Writer-XLSX-0.95.tar.gz
RUN tar xvf Excel-Writer-XLSX-0.95.tar.gz
RUN pushd Excel-Writer-XLSX-0.95
RUN perl Makefile.PL
RUN make && make install
RUN popd
RUN popd
RUN git clone https://github.com/d4t4king/lynis-report-converter.git
