#! /bin/bash
sudo -i
sudo yum update -y
swapoff -a
setenforce 0
sudo amazon-linux-extras install epel -y
sudo amazon-linux-extras install java-openjdk11 -y

# install docker 
sudo amazon-linux-extras install docker -y
sudo systemctl enable docker
sudo systemctl start docker

# install kubernetes
cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=0
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
exclude=kube*
EOF


cat <<EOF >  /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF

sysctl --system

sudo yum install -y kubeadm-1.21.3 kubelet-1.21.3 kubectl-1.21.3 --disableexcludes=kubernetes 

sudo systemctl enable kubelet 
sudo systemctl start kubelet