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

RUN apt-get update && \

# Hmm need to reinstalled upstart 
# https://github.com/docker/docker/issues/1024
    apt-get --reinstall install -y upstart && \
    apt-get install -y \
    openssh-server \
    ssh \
    ssh-client \
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
    touch /var/log/auth.log && \
    chown syslog:adm /var/log/auth.log && \
    service fail2ban start && \

# Start sshd daemon

    service ssh start && \

# setup ufw # 20150721 UFW and Iptables need root. Work in progress. 
# (yes i can ask the base to be harden). Remove the lines.
##    ufw allow 22/tcp && \
##    ufw enable && \
##    ufw default deny && \

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
    echo "docker run -it -d -P --name my_ubuntu1 ubuntu_harden_ssh" && \
    echo "########################################"

# Expose the default port
EXPOSE 22

# Set default container command
## refer to restart sshd service ### CMD ["/usr/sbin/sshd", "-D"]

CMD echo "PASSWORD For user1 is `cat password.txt`"; /bin/bash

# used this temp till figure out better solution to bash in and open port 22
# till better CMD or ENTRYPOINT
#### CMD /etc/rc.local; bash
