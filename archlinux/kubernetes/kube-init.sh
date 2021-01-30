#!/usr/bin/bash
set -euox pipefail

kubeadm version

# TODO --node-name=kube1 ?  Better/clearer to just override the hostname, via Vagrantfile, and/or cloud-init?
kubeadm init --pod-network-cidr='10.85.0.0/16' --cri-socket='unix:///run/crio/crio.sock'

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

kubectl version
kubectl get nodes
