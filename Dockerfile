############################################################
# Dockerfile to build harden Ubuntu container images
# Based on Ubuntu
# Template https://docs.docker.com/examples/running_ssh_service/
# Start : 20 July 2015
############################################################

# Set the base image
FROM ubuntu:14.04

# File Author / Maintainer
MAINTAINER Harisfazillah Jamel linuxmalaysia <linuxmalaysia@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

### Start installation

# Hmm upstart issue
# https://github.com/docker/docker/issues/1024

RUN dpkg-divert --local --rename --add /sbin/initctl && \
    ln -sf /bin/true /sbin/initctl && \
    mkdir /var/run/sshd && \

    apt-get update && \

    apt-get install -y \
    ssh \
    ssh-client \
    openssh-server \
    ufw \
    fail2ban \
    git \
    wget \
    curl \
    pwgen \
    vim-tiny && \

# Upgrade others
# refer https://github.com/docker/docker/issues/1724

    apt-get upgrade -y && \

# cleanup
    apt-get clean && \


# setup ssh server

# SSH login fix. Otherwise user is kicked off after login

    sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd && \

    echo "### End Of Installation"


### End installation

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile && \

# create the auth.log file or fail2ban will failed
# still need docker run --privileged=true or iptables will failed.
# http://www.jlee.biz/iptables-in-docker-permission-denied/
# hardening.sh will fixed start issue. This only to init needed files.
    touch /var/log/auth.log && \
    chown syslog:adm /var/log/auth.log && \
    service fail2ban restart && \

# Add user1
    useradd user1 -m -s /bin/bash && \
    pwgen -N 1 > password.txt && \
    echo "user1:`cat password.txt`" | chpasswd && \
    usermod -G sudo user1 && \
    mkdir -p /home/user1/GITHUB && \
    chown user1:user1 /home/user1/GITHUB && \

    echo "########################################" && \
    echo " " && \
    echo "PASSWORD For user1 is `cat password.txt`" && \
    echo " " && \
    echo "example to run :- " && \
    echo "docker pull linuxmalaysia/docker-ubuntu-14.04-harden" && \
    echo "docker run --privileged=true -it -d -P --name my_ubuntu1 ubuntu_harden_ssh" && \
    echo " " && \
    echo "########################################" && \

# A copy for each docker
    pwd && ls && cd /home/user1/GITHUB && \
    git clone https://github.com/HarisfazillahJamel/docker-ubuntu-14.04-harden.git && \
    cd / && pwd & ls

# Hardening Initialization and Startup Script
ADD hardening.sh /hardening.sh
RUN chmod 755 /hardening.sh

# Expose the default port
EXPOSE 22

VOLUME ["/var/run/sshd"]

# Set default container command

CMD ["/bin/bash","/hardening.sh"]
