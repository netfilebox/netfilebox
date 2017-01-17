# NetFileBox Personal Cloud Setup
* by Paul S. Russo  paul.russo@netfilebox.com
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


# Get up and running in three simple steps 
```ShellSession
1. git clone https://github.com/netfilebox/netfilebox.git
2. cd netfilebox
3. ./setup.sh
```

Setup will ask these questions
```
Enter [1] for Windows 
Enter [2] for Linux or Mac 

Enter Install Type
Enter [1] to pull pre-built images web/db/Nextcloud from NetFileBox Docker Hub Repo 
Enter [2] to build all images locally from scratch 

```
**Install type #2 is not currenly working -- it will be fixed in the next day 01/17/2017** 

After several minutes a screen like this will display.  **Wait for all three images to appear**
```
Every 2.0s: docker images                                                                                                                                             Tue Jan 17 02:44:28 2017

REPOSITORY             TAG                 IMAGE ID            CREATED             SIZE
netfilebox/nextcloud   latest              ff598d742826        9 days ago          612.5 MB
netfilebox/db          latest              d81fc9ee4499        4 months ago        381 MB
netfilebox/web         latest              0bcb1e885808        4 months ago        508.4 MB
```
Hit **ctrl-c** to continue..

The next screen will diplay this.. Wait for the repeating **Waiting for SSL keys...** messages

```
db        | 170117 02:44:43 mysqld_safe Logging to syslog.
db        | 170117 02:44:43 mysqld_safe Starting mysqld daemon with databases from /var/lib/mysql
web       | Waiting for SSL keys...
```
Hit **ctrl-c** to continue..

The last screen will show this.. 
```
writing new private key to '/opt/ssl/self-signed/netfilebox.key'
...
Country Name (2 letter code) [AU]:
```
**DON'T TYPE ANYTHING**. An automated script will fill in the values.   

When this completes, the system will be READY!
#### [https://localhost:8443/nextcloud/index.php](https://localhost:8443/nextcloud/index.php)

# What setup does...
1. select the host OS type  
2. choose the install type  
## 1. Select host type 
VM to HOST drive mount sync type differs based on the host OS.   
   * Windows uses 'virtualbox'
   * Linux / Mac OS uses 'rsync'  

This is specified in the **config.vm.synced_folder** entries in the Vagrantfile

## 2. Choose the type of install 

### The following two install types are available:
#### Type 1. pulls pre-built images maintained by NetFileBox 
   * quicker install - (13 minutes on my system) images contain applications that have been pre-configured 
   * image updates are simple to pull   

#### Type 2. build images yourself locally from scratch 
   * takes longer - images and applications are downloaded and configured locally 
   * you maintain and control updates  

---
![netfilebox-nextcloud](https://paulsrusso.github.io/netfilebox/images/netfilebox-nextcloud.png)
