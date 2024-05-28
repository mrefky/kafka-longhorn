sudo apt-get install open-iscsi
microk8s kubectl create -f https://raw.githubusercontent.com/longhorn/longhorn/v1.6.1/uninstall/uninstall.yaml
microk8s kubectl get job/longhorn-uninstall -n longhorn-system 

microk8s  kubectl delete -f https://raw.githubusercontent.com/longhorn/longhorn/v1.6.1/deploy/longhorn.yaml
microk8s kubectl delete -f https://raw.githubusercontent.com/longhorn/longhorn/v1.6.1/uninstall/uninstall.yaml


microk8s helm3 repo add longhorn https://charts.longhorn.io

microk8s helm3 repo update

microk8s kubectl create namespace longhorn-system
# for testing use "/tmp/longhorn" as storage location
microk8s helm3 install longhorn longhorn/longhorn --namespace longhorn-system \
  --set defaultSettings.defaultDataPath="/longhorn" \
  --set csi.kubeletRootDir="/var/snap/microk8s/common/var/lib/kubelet"
./ini.sh
sleep 30
microk8s.kubectl delete -f lhfe.yaml -n longhorn-system
sleep 10
microk8s.kubectl create -f lhfe.yaml -n longhorn-system
./delete_kafka.sh
./install_kafka.sh
k9s -c po -A
