# NetFileBox Personal Cloud Setup
* by Paul S. Russo  paul.russo@netfilebox.com
* Twitter: [@PaulSRusso](https://twitter.com/@PaulSRusso)
* View [My Projects](https://paulsrusso.github.io)

This setup uses Docker images that run in a Vagrant provisioned Centos VM. [Read background information](https://paulsrusso.github.io/netfilebox) on this setup.

# Prerequisites
* Download and Install <a href="https://www.virtualbox.org/wiki/Downloads" target="_blank">Virtual Box</a>
* Download and Install <a href="https://www.vagrantup.com/downloads.html" target="_blank">Vagrant</a>
* Windows users download and Install <a href="https://git-scm.com/downloads" target="_blank">Git Bash</a>   
    when prompted:
      * Select 'Use Git from Git Bash Only'   
      * Select 'Check out as-is, commit as-is'


# Get up and running in three simple steps 
```ShellSession
1. git clone https://github.com/netfilebox/netfilebox.git
2. cd netfilebox
3. ./setup.sh
```

Setup will ask these questions
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
**Wait for all three images to appear**
```
Every 2.0s: docker images                                                                                                                                             Tue Jan 17 02:44:28 2017

REPOSITORY             TAG                 IMAGE ID            CREATED             SIZE
netfilebox/nextcloud   latest              ff598d742826        9 days ago          612.5 MB
netfilebox/db          latest              d81fc9ee4499        4 months ago        381 MB
netfilebox/web         latest              0bcb1e885808        4 months ago        508.4 MB
```
Hit **ctrl-c** to continue..  
**END Install type [1] output only** 

---
The next screen will diplay this for **both install types** Wait for the repeating **Waiting for SSL keys...** messages

```
db        | 170117 02:44:43 mysqld_safe Logging to syslog.
db        | 170117 02:44:43 mysqld_safe Starting mysqld daemon with databases from /var/lib/mysql
web       | Waiting for SSL keys...
```
Hit **ctrl-c** to continue..

The last screen shows this.. 
```
writing new private key to '/opt/ssl/self-signed/netfilebox.key'
...
Country Name (2 letter code) [AU]:
```
**DON'T TYPE ANYTHING**. An automated script will fill in the values.   

When this completes, the system will be READY!
#### [https://localhost:8443/nextcloud/index.php](https://localhost:8443/nextcloud/index.php)

# What setup does...
1. Downloads, boots and updates a brand new new Centos 7 image using Vagrant 
2. Downloads Docker, Docker Compose 
3. Downloads utilities by running this command.. 
```ShellSession
sudo yum update -y && yum install -y net-tools wget curl python unzip zip cron vim epel-release
```
###Install type [1] pulls pre-built images maintained by NetFileBox 
   * quicker install - (13 minutes on my system) images contain applications that have been pre-configured 
   * image updates are simple to pull from the [NetFileBox Docker Hub Repository](https://hub.docker.com/search/?q=netfilebox)  

###Install type [2] builds images locally from scratch 
   * takes longer - (27 minutes on my system)
   * Docker images are created from scratch after downloading and configuring applications locally 
     * MySQL
     * NGINX
     * Nextcloud
   * you maintain and control updates  

---
![netfilebox-nextcloud](https://paulsrusso.github.io/netfilebox/images/netfilebox-nextcloud.png)

Below is the *baseos* Dockerfile in which all images are based.
```
FROM debian:latest
MAINTAINER Paul S. Russo  "paul.russo@netfilebox.com"
RUN apt-get update && apt-get autoremove && apt-get -y install vim curl wget zip unzip bzip2
```
