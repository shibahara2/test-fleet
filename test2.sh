ln -s /k3s /crictl
echo "runtime-endpoint: unix:///run/k3s/containerd/containerd.sock" > crictl.yaml

while true; do
    ./crictl --config crictl.yaml images
    sleep 600
done
