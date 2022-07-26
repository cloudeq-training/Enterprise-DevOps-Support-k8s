Vagrant.configure("2") do |config|

  config.vm.define "control" do |control|
    control.vm.box = "ubuntu/focal64"
    control.vm.network "private_network", ip: "192.168.40.11"
    control.vm.provider "virtualbox" do |vb|
     vb.memory = "2560"
	 vb.cpus = 2
   end
   config.vm.provision "shell", 
   path: "control-script.sh"
  end

  config.vm.define "worker1" do |worker1|
    worker1.vm.box = "ubuntu/focal64"
    worker1.vm.network "private_network", ip: "192.168.40.12"
	worker1.vm.provider "virtualbox" do |vb|
     vb.memory = "2560"
	 vb.cpus = 2
   end
   config.vm.provision "shell", 
   path: "worker-script.sh"
  end
  config.vm.define "worker2" do |worker2|
    worker2.vm.box = "ubuntu/focal64"
    worker2.vm.network "private_network", ip: "192.168.40.13"
	worker2.vm.provider "virtualbox" do |vb|
     vb.memory = "2560"
	 vb.cpus = 2
   end
   config.vm.provision "shell", 
   path: "worker-script.sh"
  end
end