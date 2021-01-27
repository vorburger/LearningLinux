# Arch Linux scripts

## Create Initial VM

    ./arch-create ~/VM-Disks/arch1

    root@archiso ~ # systemctl start sshd
    root@archiso ~ # passwd

    vorburger@laptop$
    ssh -p 2222 root@localhost
    ssh-copy-id -p 2222 root@localhost

    scp -P 2222 arch-install* root@localhost:  &&  ssh -p 2222 root@localhost bash ./arch-install

    ssh -p 2222 root@localhost umount -R /mnt


## Launch and enter Initial VM

    ./start ~/VM-Disks/arch1
    ssh -A -p 2222 root@localhost


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

    rm -rf /tmp/newos.work; mkarchiso -v -w /tmp/newos.work -o /tmp/ .

    ../../../archiso/scripts/cloud-init.sh

    ../../../archiso/scripts/run_archiso.sh -v -c cloud-init.iso -b -i /tmp/newos*.iso

    ssh -o StrictHostKeyChecking=no -o "UserKnownHostsFile /dev/null" -p 60022 localhost


## Using my own distro's ISO

Test cri-o, as per ("my!") https://wiki.archlinux.org/index.php/CRI-O#Testing.

Bootstrap Kubernetes, see also https://wiki.archlinux.org/index.php/Kubernetes:

    kubeadm init --cri-socket='unix:///run/crio/crio.sock'

Install additional packages (this will eventually be removed):

    reflector --verbose --latest 5 --sort rate --save /etc/pacman.d/mirrorlist
    pacman-key --init
    pacman-key --populate archlinux
    pacman -Sy yq
