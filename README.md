# NetFileBox Personal Cloud Setup
* Created by Paul S. Russo  paul.russo@netfilebox.com
* Twitter: [@PaulSRusso](https://twitter.com/@PaulSRusso)
* View [My Projects](https://paulsrusso.github.io)

# Prerequisites
* [Vagrant](https://www.vagrantup.com/)
* [Read more information](https://paulsrusso.github.io/netfilebox) on this setup
# Clone the repository
```
  git clone https://github.com/netfilebox/netfilebox.git
  cd netfilebox
```
# Install images pre-built by NefFileBox or build images yourself locally from scratch 
## Install images pre-built by NefFileBox   
```
cd ./vagrant
vagrant up
vagrant reload
vagrant ssh
cd netfilebox/host
sudo ./setup.sh
exit
vagrant reload
vagrant ssh
docker images
cd /opt/netfilebox
docker-compose logs
web       | Waiting for SSL keys...
ctrl c
./bin/self-signed.sh
wait for completion
```
### [https://localhost:8443/nextcloud/index.php](https://localhost:8443/nextcloud/index.php)
## Build images locally from scratch
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
ctrl c
./bin/self-signed.sh
wait for completion
```
### [https://localhost:8443/nextcloud/index.php](https://localhost:8443/nextcloud/index.php)
