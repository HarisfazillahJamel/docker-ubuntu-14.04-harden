# Docker Ubuntu 14.04 Harden With SSH - OpenSSH

Docker Container With Ubuntu 14.04 LTS harden and secure. Include SSH OpenSSH to access the server. The default user is user1 and the password in the latest builds details log. Visit this website for latest information about this docker and latest builds details.

[https://registry.hub.docker.com/u/linuxmalaysia/docker-ubuntu-14.04-harden/](https://registry.hub.docker.com/u/linuxmalaysia/docker-ubuntu-14.04-harden/)

This docker is installed with :-

- OpenSSH
- Fail2ban
- UFW with 22/tcp allow and default deny
- Harden and harden-nids packages
- docker run --privileged=true is needed by iptables

Latest information in the docker/Dockerfile and hardening[.]sh
[https://github.com/HarisfazillahJamel/docker-ubuntu-14.04-harden](https://github.com/HarisfazillahJamel/docker-ubuntu-14.04-harden)

### To Install On Your Server
```sh
docker pull linuxmalaysia/docker-ubuntu-14.04-harden
```
```sh
docker run --privileged=true -it -d -P --name my_ubuntu1 linuxmalaysia/docker-ubuntu-14.04-harden
```
You can then use docker port to find out what host port, the container's port 22 is mapped to :-
```sh
docker port my_ubuntu1 port 22
```
```sh
ssh user1@localhost -p ?????
```
### To build yourself
```sh
git clone https://github.com/HarisfazillahJamel/docker-ubuntu-14.04-harden.git
```
```sh
cd docker-ubuntu-14.04-harden
```
```sh
docker build -t docker-ubuntu-14.04-harden .
```
```sh
docker run --privileged=true -it -d -P --name my_ubuntu1 docker-ubuntu-14.04-harden
```
Haris @ LinuxMalaysia

21 July 2015
