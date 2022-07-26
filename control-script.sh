#!/bin/bash
CONTROL_IP="10.0.0.10"
echo "#####################e kernel modules and modify some system settings ######################"
cat << EOF | sudo tee /etc/modules-load.d/containerd.conf
overlay
br_netfilter
EOF
sudo modprobe overlay
sudo modprobe br_netfilter
cat <<EOF | sudo tee /etc/sysctl.d/99-kubernetes-cri.conf
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
net.bridge.bridge-nf-call-ip6tables = 1
EOF
sudo sysctl --system
echo
echo "#################Install and configure containerd.##########################"
sudo apt-get update && sudo apt-get install -y containerd
sudo mkdir -p /etc/containerd
sudo containerd config default | sudo tee /etc/containerd/config.toml
sudo systemctl restart containerd
echo
echo "##############On all nodes, disable swap.###################################"
sudo swapoff -a
echo
echo "###################On all nodes, install kubeadm, kubelet, and kubectl.##############"
sudo apt-get update && sudo apt-get install -y apt-transport-https curl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
cat << EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF
sudo apt-get update
sudo apt-get install -y kubelet=1.23.0-00 kubeadm=1.23.0-00 kubectl=1.23.0-00
sudo apt-mark hold kubelet kubeadm kubectl
echo
echo "############################On the control plane node only############################"
sudo kubeadm init --pod-network-cidr 192.168.0.0/16 --apiserver-advertise-address=$CONTROL_IP --kubernetes-version 1.23.0
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
echo
echo "#############################Verify the cluster is working.############################"
kubectl get nodes
echo
echo "###############Install the Calico network add-on.#####################################"
kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml
echo
echo "################Get the join command###############################"
kubeadm token create --print-join-command > /vagrant/worker-join 