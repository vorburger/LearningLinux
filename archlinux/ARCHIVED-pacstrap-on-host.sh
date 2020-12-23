#!/usr/bin/env bash
set -euox pipefail

# TODO This is somewhat similar to run-qemu-syslinux, and should eventually be unified,
# ideally by getting pacstrap to run in a container, like archlinux-dev.Dockerfile

# https://wiki.archlinux.org/index.php/Install_Arch_Linux_from_existing_Linux
# https://wiki.archlinux.org/index.php/Installation_guide


# FIRST we'll set up the root FS, THEN we'll create an IMG...

ROOTFS=/tmp/$1.prepare
mkdir -p $ROOTFS

# TODO shame this requires sudo.. would like to be able to specify alt. dir.
sudo pacman-key --init
sudo pacman-key --populate archlinux

# This doesn't work in a FuseFS, which is why we're doing it separately first.
sudo pacstrap -G $ROOTFS/ base linux
# TODO add linux-firmware when trying this out on baremetal


# # NOT "#!/usr/bin/guestfish -f" as that doesn't let us use arguments... instead:
# guestfish <<'EOM'

rm $1

qemu-img create -f raw $1 10G

# Intentionally using msdos instead of gpt
parted $1 mklabel msdos \
          mkpart primary ext4 0G 100%

sudo guestfish add $1 : run : mkfs ext4 /dev/sda1 : mount /dev/sda1 / : copy-in $ROOTFS/ /

#MNT=/tmp/$1
#mkdir -p $MNT
#guestmount --add $1 --mount /dev/sda1 $MNT

# TODO
# ... sudo extlinux --install /run/media/$USER/LinuxRootFS
# ... sudo cp syslinux/* /run/media/$USER/LinuxRootFS

#guestunmount $MNT

qemu-system-x86_64 -display gtk,zoom-to-fit=on -no-user-config -enable-kvm -cpu host -m 1024 -smp 2 \
  -drive file=$1,format=raw
# -cdrom ~/Downloads/archlinux-2020.12.01-x86_64.iso \
