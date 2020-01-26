#!/bin/bash
# Harisfazillah Jamel
# 21 July 2015
# https://github.com/HarisfazillahJamel/docker-ubuntu-14.04-harden

#
# Copyright (c) 2015-2020 Harisfazillah Jamel <linuxmalaysia@gmail.com>
#

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

# This is my development scripts to harden server. Im using this docker to
# applied hardening scripts. Use this Dockerfile and scripts related at your own risk.
# Harisfazillah Jamel - Kuala Lumpur - Malaysia - 25 Jan 2015 - 25 Jan 2020

# need to restart rsyslog

service rsyslog stop
service rsyslog start

logger -it ujian "test the logger"

# Need to restart cron

service cron restart

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
ufw status
ufw default deny

# Crete SSH Key

ssh-keygen -t rsa -f ~/.ssh/id_rsa -q -N ""

# restart snort

service snort restart

#### Only ssh daemon will be the last execute
# SSH run in foreground and not detached

/usr/sbin/sshd -D

exit 0
