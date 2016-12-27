<style scoped> @import url("./css/netfilebox.css"); </style>
# NetFileBox Personal Cloud Setup
* Created by Paul S. Russo  paul.russo@netfilebox.com
* Twitter: [@PaulSRusso](https://twitter.com/@PaulSRusso)
* View [My Projects](https://paulsrusso.github.io)

The environment that this runs is a Centos VM in Vagrant.   
[Read background information](https://paulsrusso.github.io/netfilebox) on this setup

# Prerequisites
* Download and Install <a href="https://www.vagrantup.com/downloads.html">Vagrant</a>

# Clone the repository
```
   git clone https://github.com/netfilebox/netfilebox.git
   cd netfilebox
```

## Choose the type of install 

### The following two install types are available:
1. pre-built images maintained by NetFileBox 
   * quicker install - images contain applications that have been pre-configured 
   * image updates are automatic
2. build images yourself locally from scratch 
   * takes longer - images and applications are downloaded and configured locally 
   * you maintain and control updates  

Both install types are simple to do. Just copy and paste the listed commands one at a time.

### Install Type 1: images pre-built by NetFileBox   
Initialize the Centos VM, dowloading Docker and creating users and groups.  
The vagrant reload is needed to start Docker 
```
cd ./vagrant
vagrant up
vagrant reload
```
Login to the system and run setup.sh  
setup.sh will install a startup script that runs when the system boots.  
It sets the environment and launches Docker containers at startup.  
```
vagrant ssh
cd netfilebox/host
sudo ./setup.sh
```
Logout the reload vagrant which reboots the system.   
When the system reboots, docker images are pulled from NetFileBox and started. 
```
exit
vagrant reload
```
Log back into the system.   
Everything is placed under /opt/netfilebox  
View the logs of the initailizing containers.    
It will take a few minutes to download the images before the logs command below shows anything.
```
vagrant ssh
cd /opt/netfilebox
docker-compose logs
```
When you see this message **Waiting for SSL keys...** then exit the log and we will generate a self-signed SSL certificate.

```
ctrl-c
./bin/self-signed.sh
```
When complete the system is ready! Logon with the browser.   
### [https://localhost:8443/nextcloud/index.php](https://localhost:8443/nextcloud/index.php)

---
### Install Type 2: Build images locally from scratch
```
cd ./vagrant
vagrant up
vagrant reload
vagrant ssh
cd ./netfilebox/dockerfiles/netfilebox
./build-all.sh
docker images
cd ~/netfilebox/host
sudo ./setup-scatch.sh
exit
vagrant reload
vagrant ssh
cd /opt/netfilebox
docker-compose logs
ctrl-c
./bin/self-signed.sh
wait for completion
```
### [https://localhost:8443/nextcloud/index.php](https://localhost:8443/nextcloud/index.php)
