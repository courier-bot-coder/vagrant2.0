
apt-get update
sudo snap install microk8s --classic
sudo usermod -a -G microk8s vagrant
sudo chown -f -R vagrant ~/.kube
newgrp microk8s
sudo apt install nodejs -y
sudo apt install npm -y
npm install express --save -y
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
cd /etc/netplan
      sudo sed -i '$a\ \ \ \ eth1:' 01-netcfg.yaml
      sudo sed -i '$a\ \ \ \ \ \ dhcp4: false' 01-netcfg.yaml
      sudo sed -i '$a\ \ \ \ \ \ addresses:' 01-netcfg.yaml
      sudo sed -i '$a\ \ \ \ \ \ \ \ - 10.254.254.13/24' 01-netcfg.yaml
      sudo sed -i '$a\ \ \ \ \ \ nameservers:' 01-netcfg.yaml
      sudo sed -i '$a\ \ \ \ \ \ \ \ addresses: [8.8.8.8]' 01-netcfg.yaml
sudo netplan apply
microk8s enable dns
microk8s enable metallb 10.64.140.43-10.64.140.49
microk8s add-node | grep 10.254.254.13 | tee /vagrant/microk8s.sh
microk8s add-node | grep 10.254.254.13 | tee /vagrant/microk8s2.sh

if ! [ -L /var/www ]; then
  rm -rf /var/www
  ln -fs /vagrant /var/www
fi