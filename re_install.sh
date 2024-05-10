sudo snap remove microk8s --purge 
sudo snap install microk8s --classic --channel=1.29/stable
microk8s.start
microk8s.status --wait-ready
sudo microk8s.enable dns 
sudo microk8s.enable dashboard 
sudo microk8s.enable storage 
sudo microk8s.enable helm3 
sudo microk8s.enable registry 
sudo microk8s.enable metallb 192.168.169.50-192.168.169.99 
sudo iptables -P FORWARD ACCEPT
microk8s.kubectl deflete -f db.yaml
microk8s.kubectl create -f db.yaml
./longhorn.sh
