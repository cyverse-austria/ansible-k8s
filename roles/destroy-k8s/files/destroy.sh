#!/bin/sh
set -x
kubeadm reset --force
apt-get remove -y kubeadm kubectl kubelet kubernetes-cni kube*
apt-get autoremove -y
[ -e ~/.kube ] && rm -rf ~/.kube
[ -e /etc/kubernetes ] && rm -rf /etc/kubernetes
[ -e /opt/cni ] && rm -rf /opt/cni
