############################################################
# Dockerfile to build harden Ubuntu container images
# Based on Ubuntu
############################################################

# Set the base image
FROM dockerbase/openssh-server

# File Author / Maintainer
MAINTAINER Harisfazillah Jamel linuxmalaysia <linuxmalaysia@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

### Start installation

RUN apt-get update && apt-get install -y \
    openssh-server \
    ssh \
    ufw \
    fail2ban \
    git \
    wget \
    curl \
    pwgen \
    vim-tiny && \

# cleanup
    apt-get clean && \

# setup ssh server

# SSH login fix. Otherwise user is kicked off after login
    sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd && \

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
    echo "PASSWORD For user1 is `cat password.txt`"

### End installation

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

# Expose the default port
EXPOSE 22

# Set default container command
CMD ["/usr/sbin/sshd", "-D"]
