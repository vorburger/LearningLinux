# Arch Linux scripts

This is for "my own distro"; whereas [archinstall](archinstall.md) documents a "normal install".

## Create OS Image with a container

This is a PITA / not (easily) possible, yet;
see [archlinux-pacstrap.Dockerfile](../containers/archlinux-pacstrap.Dockerfile),
and https://github.com/archlinux/arch-install-scripts/issues/25.


## Create OS Image using `pacstrap` on the host

Pre-requisite: Either install an (old...) `pacstrap` via `sudo dnf install arch-install-scripts pacman`,
or (better) install the latest from source: Install its own pre-requisites with `sudo dnf install asciidoc`,
then `git clone git@github.com:archlinux/arch-install-scripts.git` and `sudo make install` that.
You also need to `sudo pacman-key --init && sudo pacman-key --populate archlinux`. Now you can:

    sudo pacstrap /tmp/pacstrap/ base linux
    ../run-dir /tmp/pacstrap/

or, for our custom one:

    sudo ./arch-install ./BUILD/
    ../run-dir ./BUILD/

TODO:

1. boot using `qemu -kernel` as on https://github.com/anatol/vmtest/blob/master/docs/prepare_image.md
   Obtaining bzImage extracted from container like on https://github.com/vorburger/LearningLinux/compare/pacstrap-from-container?expand=1
1. Fix: + cp arch-install-chroot /mnt/
   cp: cannot stat 'arch-install-chroot': No such file or directory
1. Actually target directory in arch-install, mkdir it, and change /mnt/ to /tmp/pacstrap/, instead of hard-coded /mnt/
1. ssh-copy-id from host into vm:/mnt/
1. ssh from host into rebooted VM
1. mv archiso stuff below to Archive/
1. ssh "harden", like on dotfiles, or https://github.com/anatol/vmtest/blob/master/docs/prepare_image.md#build-an-arch-linux-rootfs
1. remove pacman completely, incl. sudo rm rootfs/var/cache/pacman/pkg/*
1. Try `pacstrap -N` instead sudo on Fedora 36 (on Fedora 34: "unshare: unrecognized option '--map-auto'").


## Create OS Image using a VM

This works, but is currently slow (sleeps 60s) due to [this bug](https://gitlab.archlinux.org/archlinux/arch-boxes/-/issues/153), see [this post](https://github.com/vorburger/vorburger.ch-Notes/blob/develop/linux/systemd-analyze.md):

    ./arch-create-vm ~/VM-Disks/arch1

_TODO Dogfood this project by creating my own more lightweight faster VM!_
See idea for `virt` instead of `sudo` for `arch-pacstrap-host`, described in [architecture](../docs/architecture.md).


## Launch and enter Initial VM

    ./start ~/VM-Disks/arch1
    ssh -A -p 2222 root@localhost

TODO: Why does it boot from sda3?! Switch from BIOS to UEFI? Use [booster](https://wiki.archlinux.org/title/Booster)?


## Build archiso's releng

Rebuild the default ISO image:

    mkarchiso -v -w /tmp/archiso1 /usr/share/archiso/configs/releng/

    run_archiso -v -i out/archlinux*.iso

NB the `-v` was contributed to arch in https://bugs.archlinux.org/task/69142.


# Build my own distro's ISO

This is a custom distro to work on implementing [the Roadmap](../docs/roadmap):

For now, [pending the integration](https://gitlab.archlinux.org/archlinux/archiso/-/merge_requests?scope=all&utf8=%E2%9C%93&state=opened&author_username=vorburger)
of some [code on my `archiso` fork](https://github.com/archlinux/archiso/compare/master...vorburger:cloud-init-vorburger-full):

    git clone https://github.com/archlinux/archiso.git; cd archiso; git checkout cloud-init-vorburger-full; cd ..
    git clone https://github.com/vorburger/LearningLinux.git; cd LearningLinux/archlinux/iso

    rm -rf /tmp/newos*.iso /tmp/newos.work; mkarchiso -v -w /tmp/newos.work -o /tmp/ .

    ../../../archiso/scripts/cloud-init.sh

    ../../../archiso/scripts/run_archiso.sh -v -c cloud-init.iso -b -i /tmp/newos*.iso

    ssh -o StrictHostKeyChecking=no -o "UserKnownHostsFile /dev/null" -p 60022 localhost


## Using my own distro's ISO

Install the ISO on a new disk:

    dinstall /dev/sda

then boot from that disk:

    ../../bin/run-cloud-init.sh /tmp/newos*.iso.raw

Test cri-o, as per ("my!") https://wiki.archlinux.org/index.php/CRI-O#Testing.

Bootstrap Kubernetes, see also https://wiki.archlinux.org/index.php/Kubernetes:

    kubeadm init --cri-socket='unix:///run/crio/crio.sock'

Install additional packages (this will eventually be removed):

    reflector --verbose --latest 5 --sort rate --save /etc/pacman.d/mirrorlist
    pacman-key --init
    pacman-key --populate archlinux
    pacman -Sy yq
