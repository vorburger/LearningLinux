# Arch Linux scripts

This is for "my own distro"; whereas [archinstall](archinstall.md) documents a "normal install".

## Create OS Image with a container

This is a PITA / not (easily) possible, yet;
see [archlinux-pacstrap.Dockerfile](../ARCHIVE/archlinux-pacstrap.Dockerfile),
and https://github.com/archlinux/arch-install-scripts/issues/25.


## Create OS Image using `pacstrap` on the host

Pre-requisite: Either install an (old...) `pacstrap` via `sudo dnf install arch-install-scripts pacman`,
or (better) install the latest from source: Install its own pre-requisites with `sudo dnf install asciidoc`,
then `git clone git@github.com:archlinux/arch-install-scripts.git` and `sudo make install` that.
You also need to `sudo pacman-key --init && sudo pacman-key --populate archlinux`. Now you can:

    mkdir /tmp/pacstrap && sudo pacstrap /tmp/pacstrap/ base linux
    sudo ../build-image /tmp/pacstrap vorburger:vorburger
    ../run-serial-linux /tmp/pacstrap

and, more interestingly, for our custom new Linux distro:

    sudo ./arch-install ./BUILD
    sudo ../build-image ./BUILD vorburger:vorburger
    ../run-serial-linux ./BUILD

The `arch-install` copies `~[vorburger]/.ssh/authorized_keys` from the host it runs on into the VM image, so now:

     bin/ssh-2222


## Create OS Image using a VM

This works, but is currently slow (sleeps 60s) due to [this bug](https://gitlab.archlinux.org/archlinux/arch-boxes/-/issues/153), see [this post](https://github.com/vorburger/vorburger.ch-Notes/blob/develop/linux/systemd-analyze.md):

    ./arch-create-vm BUILD/arch-create-vm1.img
    ../run-gtk-bios BUILD/arch-create-vm1.img
    ../bin/ssh-2222

_TODO Dogfood this project by creating my own more lightweight faster VM!_
See idea for `virt` instead of `sudo` for `arch-pacstrap-host`, described in [architecture](../docs/architecture.md).


## Things you can do

_TODO This is from the "old" / first approach in the `/iso/`, and not yet ported to the new image..._

Test cri-o, as per ("my!") https://wiki.archlinux.org/index.php/CRI-O#Testing.

Bootstrap Kubernetes, see also https://wiki.archlinux.org/index.php/Kubernetes:

    kubeadm init --cri-socket='unix:///run/crio/crio.sock'

Install additional packages (this will eventually be removed):

    reflector --verbose --latest 5 --sort rate --save /etc/pacman.d/mirrorlist
    pacman-key --init
    pacman-key --populate archlinux
    pacman -S yq
