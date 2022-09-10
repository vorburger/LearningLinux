# https://github.com/archlinux/arch-install-scripts/issues/25
# Despite https://wiki.archlinux.org/title/Install_Arch_Linux_via_Docker,
# this does not work, at least not on Fedora 34, with Podman instead of Docker.
#
# The problem is that pacstrap does chroot, which doesn't work in a container.
# Neither --cap-add=SYS_CHROOT nor --privileged seems sufficent for it to work.
# TODO Further debug to investigate later it if it can be made to work?

FROM index.docker.io/library/archlinux:latest

RUN pacman --noconfirm -Syu arch-install-scripts
# TODO Add: reflector ec.

RUN pacstrap -c -G -M /mnt linux base

# TODO Is it possible to use -N to "Run in unshare mode as a regular user" in a container?
# Is it possible to get this to work: "unshare: could not open '/etc/subuid': No such file or directory" ?

# https://proot-me.github.io (https://wiki.archlinux.org/title/PRoot) seems an alternative,
# but is probably redundant with and ultimately somewhat similar t pacman -N's unshare?
