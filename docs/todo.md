NeXT

* use `hello-static` as init
* have a `test-qemu` script which runs `test` through nested virtualization (later for PRs)

* boot into a https://busybox.net userland.. what init? Check out `/sbin/init` from Alpine on JSLinux
* enable networking; will require dhcpd
* support PXE booting it
* add Podman


Workstation

* qemu graphical, console with framebuffer (with Linux on top), not old text one
* Wayland
* VM that, pass through graphics card access


Physical (Bare Metal)

* make an ISO, burn to USB, boot from it
* boot a NUC with it (through BIOS' PXE, or iPXE)
* boot an old laptop with it


Fun

* start it using https://bellard.org/jslinux/
* LOW: shared FS? like https://vfsync.org


Dev

* make it possible to mount kernel sources from host (use `podman mount`; as UID mapping is PITA)
* use side car data volume container (see podman's Pod support..) to keep Kernel sources persistent
* make script set some "Kernel Hacking" options in `/home/tux/linux-stable/.config` as per
  https://medium.com/@daeseok.youn/prepare-the-environment-for-developing-linux-kernel-with-qemu-c55e37ba8ade


Optimize

* build much smaller kernel than `x86_64_defconfig` (but not as small as `tinyconfig`, which doesn't work)


UML

* fix UML crashing on host (outside of container) with "Aborted (core dumped)" using
  https://www.kernel.org/doc/Documentation/virtual/uml/UserModeLinux-HOWTO.txt
  (it may be because of `tinyconfig`?)

* UML NB `ldd linux` - make statically linked (otherwise it may not work on an Ubuntu host, given build on Fedora?)
  by making script set `CONFIG_STATIC_LINK` in /home/tux/linux-stable/.config

* fix UML crashing in-container (not on host) due to:

    Checking that ptrace can change system call numbers...ptrace: Operation not permitted
    check_ptrace : expected SIGSTOP, got status = 9_
