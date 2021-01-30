#!/usr/bin/bash
set -euox pipefail

vagrant up

vagrant upload kube-prepare.sh
vagrant ssh -- "chmod +x *.sh && sudo ./kube-prepare.sh"

vagrant reload

vagrant upload kube-init.sh
vagrant ssh -- "sudo ./kube-init.sh"
# TODO --node-name=kube1 ?  Better/clearer to just override the hostname, via Vagrantfile, and/or cloud-init?
