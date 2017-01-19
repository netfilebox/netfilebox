#!/bin/bash
cp vagrant/Vagrantfile.tplt vagrant/Vagrantfile
echo "Enter your host OS"
echo "Enter [1] for Windows "
echo "Enter [2] for Linux or Mac "
echo -n ""
read OS_SEL
case $OS_SEL in
   1 ) 
      OS="WINDOWS"
      ;;
   2 )
      OS="LINUX"
     ;;
   * )
     echo "Incorrect selection "
     exit
     ;;
esac
echo
echo "Enter install type"
echo "Enter [1] pull pre-built images from NetFileBox"
echo "Enter [2] build all images locally from scratch "
echo -n ""
read INSTALL_TYPE 
echo
case $INSTALL_TYPE in
   1 ) 
     ;;
   2 )
     ;;
   * )
     echo "Incorrect selection"
     exit
     ;;
esac
echo
echo "Configuring system..."
echo
cd vagrant
vagrant plugin install vagrant-vbguest
if [ $OS == "LINUX" ]; then
   sed -i 's/type: "virtualbox"/type: "rsync"/' Vagrantfile
   vagrant up
   sed -i 's/end #END//' Vagrantfile
   echo '  config.vm.synced_folder "../data", "/opt/netfilebox/data/web", :owner=> "vagrant", :group=>"www-data", :mount_options => ["dmode=0770", "fmode=0770"]' >> Vagrantfile
   echo "end" >> Vagrantfile
fi
if [ $OS == "WINDOWS" ]; then
   vagrant up
   sed -i 's/end #END//' Vagrantfile
   echo '  config.vm.synced_folder "../data", "/opt/netfilebox/data/web", :owner=> "vagrant", :group=>"www-data", :mount_options => ["dmode=0770", "fmode=0770"], type: "virtualbox"' >> Vagrantfile
   echo "end" >> Vagrantfile
fi
vagrant reload
if [ $INSTALL_TYPE == "1" ]; then
   vagrant ssh -c 'cd ~/netfilebox/host && sudo ./setup.sh'
   vagrant reload
   vagrant ssh -c 'watch -x docker images'
else
   vagrant reload
   vagrant ssh -c 'cd ~/netfilebox/dockerfiles/netfilebox && sudo ./build-all.sh'
   vagrant ssh -c 'cd ~/netfilebox/host && sudo ./setup-scratch.sh'
   vagrant reload
fi
vagrant ssh -c 'cd /opt/netfilebox && docker-compose logs'
vagrant ssh -c 'cd /opt/netfilebox && ./bin/self-signed.sh'

echo "Setup complete!"
echo "open https://localhost:8443/nextcloud/index.php"
