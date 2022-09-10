# cloud-init

## Background

https://cloud-init.io

https://cloudinit.readthedocs.io/en/latest/

https://wiki.archlinux.org/index.php/Cloud-init

https://gitlab.archlinux.org/archlinux/archiso/-/merge_requests/114 (et al)

https://github.com/archlinux/archiso/compare/master...vorburger:create_cloud-init.sh

https://bugs.launchpad.net/cloud-utils/+bug/1912904


## Using

1. [`../archiso/scripts/create_cloud-init.sh`](https://github.com/archlinux/archiso/compare/master...vorburger:create_cloud-init.sh)

2. start as per doc below

3. `ssh -o StrictHostKeyChecking=no -o "UserKnownHostsFile /dev/null" -p 2222 localhost`
   This will SSH to the VM into account named like the host's $USER (not root), which is what we want here.

### With ArchLinux

`run_archiso.sh`

_TODO_


### With Fedora

https://alt.fedoraproject.org/cloud/

[`run-cloud-init.sh`](../bin/run-cloud-init.sh) `~/Downloads/Fedora-Cloud-Base-33-1.2.x86_64.qcow2`

_TODO debug, as doesn't seem work._
