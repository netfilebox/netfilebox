# NetFileBox Personal Cloud Setup
* by Paul S. Russo  paul.russo@netfilebox.com
* Twitter: [@PaulSRusso](https://twitter.com/@PaulSRusso)
* View [My Projects](https://paulsrusso.github.io)


This project automates the installation and configuration of [NGINX](https://www.nginx.com/), [MySQL](https://www.mysql.com/), and [Nextcloud](https://nextcloud.com/) in an isolated environment. It creates a running system in a few simple steps.  

The setup script:    
* downloads, boots and updates a fresh [Centos VM](https://atlas.hashicorp.com/centos/boxes/7) in an isolated environment using [Vagrant](https://www.vagrantup.com/)
* installs [Docker](https://www.docker.com) and [Docker Compose](https://docs.docker.com/compose/) on the Centos VM

Choose from one of two install types:  
1. pull pre-built Docker images from the [NetFileBox Docker Hub Repository](https://hub.docker.com/search/?q=netfilebox/)  
2. build and configure Docker images locally from scratch.

The pre-built install takes between 10 and 15 minutes on my system. Building from scratch takes about 30 minutes.

It is a completely automated process. Read [background information](https://paulsrusso.github.io/netfilebox).

# Prerequisites
* Download and Install <a href="https://www.virtualbox.org/wiki/Downloads" target="_blank">Virtual Box</a>
* Download and Install <a href="https://www.vagrantup.com/downloads.html" target="_blank">Vagrant</a>
* Windows users download and Install <a href="https://git-scm.com/downloads" target="_blank">Git Bash</a>   
    when prompted:
      * Select 'Use Git from Git Bash Only'   
      * Select 'Check out as-is, commit as-is'


## Get up and running in three simple steps 
```ShellSession
1. git clone https://github.com/netfilebox/netfilebox.git
2. cd netfilebox
3. ./setup.sh
```

Setup prompts:
```
Enter your host OS
Enter [1] for Windows 
Enter [2] for Linux or Mac 

Enter install type
Enter [1] pull pre-built images from NetFileBox
Enter [2] build all images locally from scratch 
```

---
**BEGIN Install type [1] only output**  
After several minutes a screen like this will display for install type [1].  
```
Every 2.0s: docker images                                                                                                                                             Tue Jan 17 02:44:28 2017

REPOSITORY             TAG                 IMAGE ID            CREATED             SIZE
netfilebox/nextcloud   latest              ff598d742826        9 days ago          612.5 MB
netfilebox/db          latest              d81fc9ee4499        4 months ago        381 MB
netfilebox/web         latest              0bcb1e885808        4 months ago        508.4 MB
```
**Wait for all three images to appear**, the hit **[ctrl-c]** to continue..  
**END Install type [1] output only** 

---
**Both install types** display this next screen 

```
db        | 170117 02:44:43 mysqld_safe Logging to syslog.
db        | 170117 02:44:43 mysqld_safe Starting mysqld daemon with databases from /var/lib/mysql
web       | Waiting for SSL keys...
```
Wait for the repeating **Waiting for SSL keys...** message, then hit **[ctrl-c]** to continue..

**Both install types** display this last screen 
```
writing new private key to '/opt/ssl/self-signed/netfilebox.key'
...
Country Name (2 letter code) [AU]:
```
**DON'T TYPE ANYTHING**. An automated script fills in the values and generates self-signed SSL keys used by the NGINX web server.   

When complete, launch [https://localhost:8443/nextcloud/index.php](https://localhost:8443/nextcloud/index.php)   
If you wish to try a differnet install type, or setup fails for some reason, re-run it.  
```ShellSession
cd vagrant 
vagrant destroy -f
cd ../
rm -f ./data && mkdir ./data
./setup.sh
```

---
![netfilebox-nextcloud](https://paulsrusso.github.io/netfilebox/images/netfilebox-nextcloud.png)

Below is the *baseos* Dockerfile in which all images are based.
```
FROM debian:latest
MAINTAINER Paul S. Russo  "paul.russo@netfilebox.com"
RUN apt-get update && apt-get autoremove && apt-get -y install vim curl wget zip unzip bzip2
```
