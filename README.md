Docker Container With Ubuntu 14.04 LTS harden and secure. Include SSH to access the server. Default user is user1 and the password in latest build details.

https://registry.hub.docker.com/u/linuxmalaysia/docker-ubuntu-14.04-harden/

1) OpenSSH
2) Fail2ban
3) UFW with 22/tcp allow and default deny

Latest info in the docker/Dockerfile and hardening.sh

https://github.com/HarisfazillahJamel/docker-ubuntu-14.04-harden

docker pull linuxmalaysia/docker-ubuntu-14.04-harden

docker run --privileged=true -it -d -P --name my_ubuntu1 linuxmalaysia/docker-ubuntu-14.04-harden

docker port my_ubuntu1 port

ssh user1@localhost -p ?????

To build yourself

git clone https://github.com/HarisfazillahJamel/docker-ubuntu-14.04-harden.git

cd docker-ubuntu-14.04-harden

docker build -t docker-ubuntu-14.04-harden .

docker run --privileged=true -it -d -P --name my_ubuntu1 docker-ubuntu-14.04-harden

Haris @ LinuxMalaysia

21 July 2015
