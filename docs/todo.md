NeXT

* mount all /dev/*, /dev/urandom
* Fedora?!
* Alpine? is `/sbin/init` from Alpine on JSLinux better?
*  `/init` should be added in `image2initrd` from the `CMD` in the `Dockerfile` obtained by `podman inspect`

* upstream contribute better error message if no /init
* enable networking; will require dhcpd
* contribute this e.g. to http://www.linuxfromscratch.org ?

* support PXE booting it
* add Podman
* study gvisor

* https://godarch.com ?


Workstation

* qemu graphical, console with framebuffer (with Linux on top), not old text one
* Wayland
* VM that, pass through graphics card access


Physical (Bare Metal)

* https://buildroot.org ?
* Dracut? https://fedoramagazine.org/initramfs-dracut-and-the-dracut-emergency-shell/
  https://github.com/dracutdevs/dracut (also https://fedoraproject.org/wiki/Dracut)
* make an ISO, burn to USB, boot from it; test it with qemu* -cdrom IMAGE.iso
* boot a NUC with it (through BIOS' PXE, or iPXE)
* boot an old laptop with it!  powertop and throttle CPU when not typing or touching screen or moving mouse?
* [import disk image to Google Cloud](https://cloud.google.com/compute/docs/import/import-existing-image),
  similarly to e.g. https://thekev.in/blog/2019-08-05-dockerfile-bootable-vm/index.html
  Automate this, and offer CI/CD?


Fun

* have a `test-qemu` script which runs `test` through nested virtualization (later, for CI PRs)
* start it using https://bellard.org/jslinux/
* LOW: shared FS? like https://vfsync.org


Dev

* make it possible to mount kernel sources from host (use `podman mount`; as UID mapping is PITA)
* use side car data volume container (see podman's Pod support..) to keep Kernel sources persistent
* make script set some "Kernel Hacking" options in `/home/tux/linux-stable/.config` as per
  https://medium.com/@daeseok.youn/prepare-the-environment-for-developing-linux-kernel-with-qemu-c55e37ba8ade
* gdb: ./scripts/config -e DEBUG_INFO -e GDB_SCRIPTS, -append nokaslr, as in:
https://nickdesaulniers.github.io/blog/2018/10/24/booting-a-custom-linux-kernel-in-qemu-and-debugging-it-with-gdb/
* mount devtmpfs /dev?


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
