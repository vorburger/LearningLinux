# NixOS

## ToDo

1. Test `nixos-install --no-root-passwd`

1. Additional user, with SSH public key

1. Disable nixos@ user auto-login on console

1. Install packages from a cache, instead of massive build each time

1. UEFI: Try with VMM or directly with `qemu`, or fix in Boxes

## Initial Installation

1. Boot an ISO from https://nixos.org/download/#nixos-iso e.g. in Boxes (uses BIOS; as UEFI is NOK)

1. `passwd` to set a password to be able to SSH into it

1. `./install` (change the VM's IP address, shown by `ip a`, in the script; or make it an argument)

1. Rebooting the VM, e.g. with `sudo reboot now` should now boot into a new NixOS mach!

## Tips

* `lsblk` to see disks; in a VM it's probably `vda`

* `mkdir /run/user/1000/nixos && sshfs nixos@192.168.122.121:/home/nixos /run/user/1000/nixos`

## Troubleshooting

### installation of GRUB on /dev/vda failed: No such file or directory

    building '/nix/store/hixs37bzblpi2falap5h1zm3lyiclcj1-etc.drv'...
    building '/nix/store/cbysm1gaakvrd25jwcz9irq0vkbz0i54-nixos-system-nixos1-24.05.1135.9b5328b7f761.drv'...
    /nix/store/xgd9xhx0crq6nc64zh99bclxdxl3jm22-nixos-system-nixos1-24.05.1135.9b5328b7f761
    installing the boot loader...
    setting up /etc...
    updating GRUB 2 menu...
    installing the GRUB 2 boot loader on /dev/vda...
    Installing for i386-pc platform.
    /nix/store/m8lawbdn57wxysh55lbga11lhiwisj5k-grub-2.12/sbin/grub-install: warning: File system `ext2' doesn't support embedding.
    /nix/store/m8lawbdn57wxysh55lbga11lhiwisj5k-grub-2.12/sbin/grub-install: warning: Embedding is not possible.  GRUB can only be installed in this setup by using blocklists.  However, blocklists are UNRELIABLE and their use is discouraged..
    /nix/store/m8lawbdn57wxysh55lbga11lhiwisj5k-grub-2.12/sbin/grub-install: error: will not proceed with blocklists.
    /nix/store/gnd59bhy086gwrv2h5s7r34c43197hch-install-grub.pl: installation of GRUB on /dev/vda failed: No such file or directory
    installation finished!

This initially happened because I had `mkfs.ext4 -L nixos /dev/vda` (the disk) instead of `/dev/vda1` (the partition).
