# Need to restart fail2ban

service fail2ban stop
rm /var/run/fail2ban/fail2ban.sock
service fail2ban start

# Need to restart ssh and stop to init files

service ssh restart
service ssh stop

# setup ufw # 20150721 UFW and Iptables need root. Work in progress.
# (yes i can ask the base to be harden). Remove the lines.

ufw allow 22/tcp
ufw enable
## disable till all confirm ### ufw default deny

# run as daemon

/usr/sbin/sshd -D

exit 0
