############################################################
# Dockerfile to build harden Ubuntu container images
# Based on Ubuntu
############################################################

# Set the base image
FROM dockerbase/openssh-server

# File Author / Maintainer
MAINTAINER Harisfazillah Jamel linuxmalaysia <linuxmalaysia@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

# Installed needed tools

RUN apt-get update && apt-get install -y \
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

# setup ufw
    ufw allow 22/tcp && \
    ufw enable && \
    ufw default deny && \

# Add user1
    useradd user1 -m -s /bin/bash && \
    pwgen -N 1 > password.txt && \
    echo "user1:`cat password.txt`" | chpasswd && \
    usermod -G sudo user1 && \
    mkdir -p /home/user1/GITHUB && \
    chown user1:user1 /home/user1 /home/user1/GITHUB && \
    echo "PASSWORD For user1 is `cat password.txt`"


# Expose the default port
EXPOSE 22

# Default port to execute the entrypoint (ssh)
CMD ["--port 2202"]

# Default command
CMD /etc/rc.local; bash
