# Arch Linux scripts

## Create VM

    ./arch-create arch1

    root@archiso ~ # systemctl start sshd
    root@archiso ~ # passwd

    vorburger@laptop$
    ssh -p 2222 root@localhost
    ssh-copy-id -p 2222 root@localhost

    scp -P 2222 arch-install* root@localhost:  &&  ssh -p 2222 root@localhost bash ./arch-install

    ssh -p 2222 root@localhost umount -R /mnt


## Launch and enter VM

    ./start ~/VM-Disks/arch1
    ssh -p 2222 root@localhost


# TODO

1. ssh NOT working?
1. https://wiki.archlinux.org/index.php/Security#SSH
