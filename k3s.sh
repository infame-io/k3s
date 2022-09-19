# multipass launch -n k3s -c 2 -m 1024M -d 5G focal
# multipass shell k3s
# curl -sfL https://get.k3s.io | K3S_KUBECONFIG_MODE=644 sh -
K3S_IP=$(multipass info k3s | grep IPv4 | awk '{print $2}')
echo $K3S_IP
multipass exec k3s sudo cat /etc/rancher/k3s/k3s.yaml > k3s.yaml
multipass exec k3s sudo cat /var/lib/rancher/k3s/server/node-token > k3s-node-token
NODE_TOKEN=$(cat k3s-node-token)
echo $NODE_TOKEN
sed -i '' "s/127.0.0.1/${K3S_IP}/" k3s.yaml
echo "Exporting KUBECONFIG ${PWD}/k3s.yaml"
export KUBECONFIG=${PWD}/k3s.yaml
echo "curl -sfL https://get.k3s.io | K3S_URL=https://${K3S_IP}:6443 K3S_TOKEN=${NODE_TOKEN} sh -"
# multipass launch -n k3s-node1 -c 2 -m 1024M -d 5G focal
# multipass shell k3s-node1
