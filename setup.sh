#!/bin/bash
cp vagrant/Vagrantfile.tplt vagrant/Vagrantfile
echo "What is your host OS"
echo "Enter [1] for Windows "
echo "Enter [2] for Linux or Mac "
echo -n ""
read OS
echo
case $OS in
   1 ) 
      OS="WIN"
      echo "Selected [Windows]"
      ;;
   2 )
      OS="LINUX"
      echo "Selected: [Linux or Mac]"
     ;;
   * )
     echo "incorrect selection"
     exit
     ;;
esac
echo
echo "Enter Install Type"
echo "Enter [1] to pull pre-built images from NetFileBox"
echo "Enter [2] to build all images locally from scratch "
echo -n ""
read INSTALL_TYPE 
echo
echo "Selected install type # $INSTALL_TYPE"
case $INSTALL_TYPE in
   1 ) 
      ;;
   2 )
     ;;
   * )
     echo "incorrect selection"
     exit
     ;;
esac
echo
echo "Configuring system..."
echo

if [ $OS == "LINUX" ]; then
   sed -i 's/type: "virtualbox"/type: "rsync"/' vagrant/Vagrantfile
fi
vagrant plugin install vagrant-vbguest
cd vagrant
vagrant up
sed -i 's/end #END//' Vagrantfile
if [ $OS == "LINUX" ]; then
   echo '  config.vm.synced_folder "../data", "/opt/netfilebox/data/web", :owner=> "vagrant", :group=>"www-data", :mount_options => ["dmode=0770", "fmode=0770"], type: "rsync"' >> Vagrantfile
else
   echo '  config.vm.synced_folder "../data", "/opt/netfilebox/data/web", :owner=> "vagrant", :group=>"www-data", :mount_options => ["dmode=0770", "fmode=0770"], type: "virtualbox"' >> Vagrantfile
fi
echo "end" >> Vagrantfile
vagrant reload
if [ $INSTALL_TYPE == "1" ]; then
   vagrant ssh -c 'cd netfilebox/host && sudo ./setup.sh'
else
   vagrant ssh -c 'cd netfilebox/host && sudo ./setup-scratch.sh'
fi
vagrant reload
vagrant ssh -c 'watch -x docker images'
vagrant ssh -c 'cd /opt/netfilebox && docker-compose logs'
vagrant ssh -c 'cd /opt/netfilebox && ./bin/self-signed.sh'

echo "Setup complete!"
echo "open https://localhost:8443/nextcloud/index.php"
