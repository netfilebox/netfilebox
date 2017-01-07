# NetFileBox Personal Cloud Setup
* Created by Paul S. Russo  paul.russo@netfilebox.com
* Twitter: [@PaulSRusso](https://twitter.com/@PaulSRusso)
* View [My Projects](https://paulsrusso.github.io)

The environment that this runs is a Centos VM in Vagrant. [Read background information](https://paulsrusso.github.io/netfilebox) on this setup.

# Prerequisites
* Download and Install <a href="https://www.virtualbox.org/wiki/Downloads" target="_blank">Virtual Box</a>
* Download and Install <a href="https://www.vagrantup.com/downloads.html" target="_blank">Vagrant</a>
* Windows users download and Install <a href="https://git-scm.com/downloads" target="_blank">Git Bash</a>   
    when prompted:
      * Select 'Use Git from Git Bash Only'   
      * Select 'Check out as-is, commit as-is'


# Clone the repository
```ShellSession
git clone https://github.com/netfilebox/netfilebox.git
cd netfilebox
vagrant plugin install vagrant-vbguest
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
The three commands below will install, update and configure Centos on Vagrant.  It will download and install Docker and create the necessary users and groups for the system.
```ShellSession
cd ./vagrant
vagrant up
```
Edit the VagrantFile and uncomment out thes data directory, then reload.
```
vim VagrantFile
:51
x
:wq
vagrant reload
```

Login to the VM and run setup.sh. This script sets environment variables and configures another script to pull the Docker images from NetFileBox docker hub repository and launch the containers at startup.   
```ShellSession
vagrant ssh
cd netfilebox/host
sudo ./setup.sh
```
Logout out the VM and reload vagrant to reboot the system. Docker images are pulled from NetFileBox and started. It will take a few minutes depending on your connection speed.
```ShellSession
exit
vagrant reload
```
Log back into the system and type *docker images*
```ShellSession
vagrant ssh
docker images
```
When the three images (db, web, and nextcloud) have been downloaded view the logs of the initailizing containers   
```ShellSession
cd /opt/netfilebox
docker-compose logs
```
Everything is placed under /opt/netfilebox   
When you see this message **Waiting for SSL keys...** then exit the log and we will generate a self-signed SSL certificate.

```ShellSession
ctrl-c
./bin/self-signed.sh
```
**Don't type anything**. An automated script fills out the values for the ssh key generation. When complete the system is ready! Logon with the browser.   
### [https://localhost:8443/nextcloud/index.php](https://localhost:8443/nextcloud/index.php)

---
### Install Type 2: Build images locally from scratch
```ShellSession
cd ./vagrant
vagrant up
vim VagrantFile
:51
x
:wq
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
