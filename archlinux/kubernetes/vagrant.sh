#!/usr/bin/bash
set -euox pipefail

vagrant up

vagrant upload kube-prepare.sh
vagrant ssh -- "chmod +x *.sh && sudo ./kube-prepare.sh"

vagrant reload

vagrant upload kube-init.sh
vagrant ssh -- "sudo ./kube-init.sh"
# TODO --node-name=kube1 ?  Better/clearer to just override the hostname, via Vagrantfile, and/or cloud-init?

# inspired by kube-init.sh
vagrant ssh -- "mkdir .kube/ ; sudo cp -v /etc/kubernetes/admin.conf /home/vagrant/.kube/ ; sudo chown vagrant:vagrant /home/vagrant/.kube/admin.conf"
mv ~/.kube/config ~/.kube/config_$(date +%F_%H:%M) || true
vagrant_ssh="$(mktemp -t vagrant_ssh.XXXXXXXXXX)"
vagrant ssh-config >"$vagrant_ssh"
scp -F "$vagrant_ssh" default:/home/vagrant/.kube/admin.conf "$HOME/.kube/config"
vagrant ssh -- "rm /home/vagrant/.kube/admin.conf"
rm "$vagrant_ssh"

vagrant upload kube-hello.sh
vagrant ssh -- "sudo ./kube-hello.sh"

./kube-hello.sh
