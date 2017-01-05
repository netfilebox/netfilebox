This is an externally mounted from the VM to host.    

All database data files, web logs and NextCloud data will be written here.

To change to a different location, change this line in the VagrantFile
config.vm.synced_folder "../data", "/opt/netfilebox/data", type: "virtualbox
