# Harisfazillah Jamel
# 21 July 2015
# https://github.com/HarisfazillahJamel/docker-ubuntu-14.04-harden

# Need to restart fail2ban
# fail2ban.sock need to be deleted

service fail2ban stop
rm /var/run/fail2ban/fail2ban.sock
service fail2ban start

# Need to restart ssh and stop to initalize files

service ssh restart
service ssh stop

# docker run --privileged=true need to be used for iptables related.

ufw allow 22/tcp
ufw enable
ufw default deny

# run as daemon

/usr/sbin/sshd -D

exit 0
