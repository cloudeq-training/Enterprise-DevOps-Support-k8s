Vagrant.configure("2") do |config|
  config.vm.provision "shell", inline: <<-SHELL
        echo "10.0.0.10  k8s-control" >> /etc/hosts
        echo "10.0.0.11  k8s-worker1" >> /etc/hosts
        echo "10.0.0.12  k8s-worker2" >> /etc/hosts
    SHELL

  config.vm.define "control" do |control|
    control.vm.box = "ubuntu/focal64"
    control.vm.hostname = "k8s-control"
    control.vm.network "private_network", ip: "10.0.0.10"
    control.vm.provider "virtualbox" do |vb|
     vb.memory = "4096"
	 vb.cpus = 2
   end
   control.vm.provision "shell", 
   path: "control-script.sh"
  end

  config.vm.define "worker1" do |worker1|
    worker1.vm.box = "ubuntu/focal64"
    worker1.vm.hostname = "k8s-worker1"
    worker1.vm.network "private_network", ip: "10.0.0.11"
	  worker1.vm.provider "virtualbox" do |vb|
     vb.memory = "2048"
	 vb.cpus = 2
   end
   worker1.vm.provision "shell", 
   path: "worker-script.sh"
  end
  config.vm.define "worker2" do |worker2|
    worker2.vm.box = "ubuntu/focal64"
    worker2.vm.hostname = "k8s-worker2"
    worker2.vm.network "private_network", ip: "10.0.0.12"
	  worker2.vm.provider "virtualbox" do |vb|
     vb.memory = "2048"
	 vb.cpus = 2
   end
   worker2.vm.provision "shell", 
   path: "worker-script.sh"
  end
end