NeXT

* https://wiki.syslinux.org/wiki/index.php?title=Development/Testing
* make an ISO, burn to USB, boot from it; test it with qemu* -cdrom IMAGE.iso

* capture network traffice with `-net dump`, inspect `qemu-vlan0.pcap` with.. wireshark?
* busybox with networking..
  why does it only get an IPv6, no IPv4? `ifconfig` (`ip addr show`) Just compile Kernel with IPv4 only.. ;)
  why does `ping 8.8.8.8` not work? `route -a` (`ip route`)
  check out https://git.busybox.net/busybox/tree/networking/ifupdown.c

* https://godarch.com?


Dev

* read https://0xax.gitbooks.io/linux-insides/content/
* read https://tldp.org/HOWTO/Linux-i386-Boot-Code-HOWTO/index.html

* make script set some "Kernel Hacking" options in `/home/tux/linux-stable/.config` as per
  https://medium.com/@daeseok.youn/prepare-the-environment-for-developing-linux-kernel-with-qemu-c55e37ba8ade
* gdb: ./scripts/config -e DEBUG_INFO -e GDB_SCRIPTS, -append nokaslr, as in:
https://nickdesaulniers.github.io/blog/2018/10/24/booting-a-custom-linux-kernel-in-qemu-and-debugging-it-with-gdb/

* make it possible to mount kernel sources from host (use `podman mount`; as UID mapping is PITA)
* upstream contribute better error message if no /init

* make microvm shutdown cleanly; https://github.com/qemu/qemu/blob/master/docs/microvm.rst#triggering-a-guest-initiated-shut-down, Kernel should use https://en.wikipedia.org/wiki/Triple_fault, but this remains stuck:

    qemu-system-x86_64 -machine microvm -no-reboot -kernel /tmp/bzImage -append "console=ttyS0 reboot=t" -initrd hello-initrd.gz -enable-kvm -m 512 -serial stdio -display none -nic none

* build hello.c with klibc instead of glibc
* where does https://git.kernel.org/pub/scm/libs/klibc/klibc.git/tree/usr/klibc
  or e.g. https://elixir.bootlin.com/glibc/latest/source/io/symlink.c "call the kernel"? (`man syscalls`)
* build a "hello, world" without any *lib* just "raw direct syscall" (`man syscall`)

* https://buildroot.org/downloads/manual/manual.html#_init_system
  https://git.busybox.net/busybox/tree/init/init.c?h=1_25_stable
* https://bootlin.com/docs/ ?
* use side car data volume container (see podman's Pod support..) to keep Kernel sources persistent
* mount devtmpfs /dev?
* Arch?
* Alpine? https://wiki.archlinux.org/index.php/intel_graphics
* Fedora?
* https://en.wikipedia.org/wiki/C_standard_library#Implementations...
  https://en.wikipedia.org/wiki/GNU_C_Library, VS
  https://en.wikipedia.org/wiki/Musl, VS
  (https://en.wikipedia.org/wiki/UClibc, VS)
  https://en.wikipedia.org/wiki/Bionic_(software), VS
  https://en.wikipedia.org/wiki/Klibc


Networking

* replace `-net user` with a TUN/TAP network bridged to the host's https://wiki.syslinux.org/wiki/index.php?title=Development/Testing#TUN.2FTAP_network
* connect several VMs among themselves, using `-netdev socket` (or `-nic socket` or `-net socket`), see https://www.qemu.org/docs/master/system/net.html#connecting-emulated-networks-between-qemu-instances


Workstation

* https://wiki.archlinux.org/index.php/QEMU#virtio qemu graphical console with framebuffer (with Linux on top)
  `qemu-system-x86_64 -kernel /tmp/bzImage -append "" -initrd busybox-init-initrd.gz --enable-kvm -m 512 -nic none -vga virtio [-display sdl,gl=on]`
  but keyboard layout needs to be fixed (and font is very ugly);
  Ctrl-Alt-F makes it feel very real! ;)
* https://wiki.archlinux.org/index.php/intel_graphics
* Wayland
* VM that, pass through graphics card access


Physical (Bare Metal)

* support PXE booting in qemu
* https://buildroot.org ?
* Dracut? https://fedoramagazine.org/initramfs-dracut-and-the-dracut-emergency-shell/
  https://github.com/dracutdevs/dracut (also https://fedoraproject.org/wiki/Dracut)
* boot a NUC with it (through BIOS' PXE, or iPXE)
* consider  http://www.linuxfromscratch.org/blfs/view/svn/postlfs/firmware.html
  and https://01.org/linuxgraphics/downloads/firmware/
* boot an old laptop with it!  powertop and throttle CPU when not typing or touching screen or moving mouse?
* [import disk image to Google Cloud](https://cloud.google.com/compute/docs/import/import-existing-image),
  similarly to e.g. https://thekev.in/blog/2019-08-05-dockerfile-bootable-vm/index.html
  Automate this, and offer CI/CD?


Cloud

* add Podman
* study gVisor
* what is https://github.com/containers/bubblewrap?


ARM

* read https://www.kernel.org/doc/Documentation/arm/Booting and
  https://www.kernel.org/doc/Documentation/arm64/booting.txt
* qemu-system-arm: "hello, world" how to?
    $ qemu-system-arm -machine virt
    $ qemu-system-arm -machine raspi2


Android

* How to make an old Android boot a self built Kernel and this project's "hello, world"?
* https://elinux.org/Android_Portal



Chrome OS

* TBD


Fun

* have a `test-qemu` script which runs `test` through nested virtualization (later, for CI PRs)
* start it using https://bellard.org/jslinux/
* LOW: shared FS? like https://vfsync.org


Optimize

* build much smaller kernel than `x86_64_defconfig` (but not as small as `tinyconfig`, which doesn't work)
* apply https://github.com/qemu/qemu/blob/master/docs/microvm.rst#triggering-a-guest-initiated-shut-down


UML

* fix UML crashing on host (outside of container) with "Aborted (core dumped)" using
  https://www.kernel.org/doc/Documentation/virtual/uml/UserModeLinux-HOWTO.txt
  (it may be because of `tinyconfig`?)

* UML NB `ldd linux` - make statically linked (otherwise it may not work on an Ubuntu host, given build on Fedora?)
  by making script set `CONFIG_STATIC_LINK` in /home/tux/linux-stable/.config

* fix UML crashing in-container (not on host) due to:

    Checking that ptrace can change system call numbers...ptrace: Operation not permitted
    check_ptrace : expected SIGSTOP, got status = 9_
