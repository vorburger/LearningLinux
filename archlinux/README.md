Scripts to play with Arch Linux:

    ./arch-create arch1

    root@archiso ~ # systemctl start sshd
    root@archiso ~ # passwd

    vorburger@laptop$
    ssh -p 2222 root@localhost
    ssh-copy-id -p 2222 root@localhost

    scp -P 2222 arch-install* root@localhost:  &&  ssh -p 2222 root@localhost bash ./arch-install

    ssh -p 2222 root@localhost umount -R /mnt && reboot


TODO

1. ssh -p 2222 root@localhost umount -R /mnt && reboot
1. script enter
1. https://wiki.archlinux.org/index.php/Security#SSH
