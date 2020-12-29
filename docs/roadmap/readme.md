# Roadmap

_see also [TODO](../docs/todo.md), and Notes/ToDo/WorldCloud/apps.md_


## Arch

1. ISO has SSHD & Cloud Init

1. ISO can rebuild itself (and self-test, nested KVM) #dogfood


## Containers

1. ISO includes `runc` (`crun`?), `cri-o` and `kubelet` with self-test samle container

1. ISO can build containers traditionally ("outside")

1. ISO has `sshd` as container (pubkey from Cloud Init)

1. ISO can build containers from within containers

1. ISO has read-only root filesystem


## IPFS #storage

1. ISO has `ipfs` (systemd) _(and `/ipfs` & `/ipns` ?)_

1. Container proc can add content to nodes' IPFS
   Just forward daemon port into containers? Doc/demo.

1. Two ISO form an IPFS cluster together

1. Container proc can pin in cluster

1. Cluster supports Pin API

1. Federated Pin API dispatcher service allows pinning in cluster and externally e.g. on Piñata et al.


## Identity



## Tools

1. Roadmap (this) is auto synchronized with GitHub Issues & Projects #plan #doc

1. [Be](https://github.com/vorburger/b)? #be #build

1. Roadmap has a Tag Word Cloud image #doc
   The `##` project name section headers are just tags as well.
