This is an externally mounted from the VM to host.    

Web logs and NextCloud data will be written here.

To change to a different location, change the '../data' in this line in the VagrantFile

config.vm.synced_folder "../data", "/opt/netfilebox/data/web", type: "virtualbox
