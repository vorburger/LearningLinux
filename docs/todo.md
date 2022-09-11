_see also [Roadmap](roadmap/) & GTasks!_

New

1. separate syslinux scripting from in-VM; should be possible to build on-host as well
1. Clean-up duplications in this repo, implement the [Architecture](architecture.md) consistently.

1. Re-add https://github.com/vorburger/LearningLinux/blob/develop/archlinux/iso/packages.x86_64 to a new (!) image
1. Try `pacstrap -N` instead sudo on Fedora 36 (on Fedora 34: "unshare: unrecognized option '--map-auto'").

1. Build a distro which allows to "dogfood" the [Architecture](architecture.md)
1. Make this distro have a read-only root filesystem, and writable ephemeral /var and /home etc.
   on another volume. Remember systemd does some one-time first boot initialization - how, stored where?
1. Make this distro entirely completely uterly rootless - sudo is impossible!!
1. Remove pacman completely, incl. sudo rm rootfs/var/cache/pacman/pkg/*

1. Unify `run-serial` and `run-gtk` into a `run serial | gtk [linux | bios | uefi]`
   like https://gitlab.archlinux.org/archlinux/archiso/-/blob/master/scripts/run_archiso.sh
1. Try UEFI with uefistub... needs https://wiki.archlinux.org/title/Unified_kernel_image ?
1. Try [booster](https://wiki.archlinux.org/title/Booster)
1. Try [pixiecore](https://github.com/danderson/netboot/tree/master/pixiecore) from qemu
1. Test automation with... bash? ch.vorburger.exec? https://github.com/anatol/vmtest?
   See also https://fadeevab.com/how-to-setup-qemu-output-to-console-and-automate-using-shell-script.
1. Check out https://github.com/libguestfs/supermin/blob/master/examples/build-basic-vm.sh ?


[ArchInstall](archinstall.md)

1. setup.sh: ssh-copy-id, disable password login, and doc to change vorburger's password
1. desktop.sh
1. sudo with yubikey (through PAM)
1. avoid `passwd` through cloudinit


First

* ssh "harden", like on https://github.com/vorburger/vorburger-dotfiles-bin-etc/blob/master/container/sshd/Dockerfile, or https://github.com/anatol/vmtest/blob/master/docs/prepare_image.md#build-an-arch-linux-rootfs
* https://wiki.archlinux.org/index.php/Security#SSH
* https://wiki.archlinux.org/index.php/OpenSSH#Deny

* new _archlinux-cn_ repo, with initial text from Notes/ToDo/MyOS.md

* RAM? https://gitlab.archlinux.org/archlinux/archiso/-/merge_requests/118/diffs


NeXT

* add kubelet with systemd unit, from https://wiki.archlinux.org/index.php/Kubernetes

* use https://kubernetes.io/docs/tasks/configure-pod-container/static-pod/ for first demo

* read https://cluster-api.sigs.k8s.io

* kubevirt? Note https://github.com/kubevirt/kubevirt/blob/master/docs/cloud-init.md


Later

* PXE https://wiki.archlinux.org/index.php/Diskless_system

* replace `expect` with https://github.com/vorburger/vexpect

* make it possible to mount kernel sources from host (use `podman mount`; as UID mapping is PITA)
* upstream contribute better error message if no /init

* packages! ;) KISS - just TAR! Start with making 2 packages for busybox + bas, instead doing that during `init`
  AKA "Docker Mods" https://github.com/linuxserver/docker-mods

* logging with [graylog](https://docs.graylog.org/) (alternative: [logstash](https://www.elastic.co/guide/en/logstash/master/index.html)), fed by:
  * https://github.com/syslog-ng/syslog-ng
  * https://www.rsyslog.com/category/guides-for-rsyslog/ (and https://www.rsyslog.com/doc/master/)
  * https://www.fluentd.org

* https://www.kernel.org/doc/html/latest/networking/netconsole.html


Dev

* read https://0xax.gitbooks.io/linux-insides/content/
* read https://tldp.org/HOWTO/Linux-i386-Boot-Code-HOWTO/index.html

* make script set some "Kernel Hacking" options in `/home/tux/linux-stable/.config` as per
  https://medium.com/@daeseok.youn/prepare-the-environment-for-developing-linux-kernel-with-qemu-c55e37ba8ade
* gdb: ./scripts/config -e DEBUG_INFO -e GDB_SCRIPTS, -append nokaslr, as in:
https://nickdesaulniers.github.io/blog/2018/10/24/booting-a-custom-linux-kernel-in-qemu-and-debugging-it-with-gdb/

* build hello.c with klibc instead of glibc
* where does https://git.kernel.org/pub/scm/libs/klibc/klibc.git/tree/usr/klibc
  or e.g. https://elixir.bootlin.com/glibc/latest/source/io/symlink.c "call the kernel"? (`man syscalls`)
* build a "hello, world" without any *lib* just "raw direct syscall" (`man syscall`)

  https://git.busybox.net/busybox/tree/init/init.c?h=1_25_stable
* https://bootlin.com/docs/ ?
* use side car data volume container (see podman's Pod support..) to keep Kernel sources persistent
* mount devtmpfs /dev?

* https://en.wikipedia.org/wiki/C_standard_library#Implementations...
  https://en.wikipedia.org/wiki/GNU_C_Library, VS
  https://en.wikipedia.org/wiki/Musl, VS
  (https://en.wikipedia.org/wiki/UClibc, VS)
  https://en.wikipedia.org/wiki/Bionic_(software), VS
  https://en.wikipedia.org/wiki/Klibc


Storage

* https://github.com/anatol/smart.go for monitoring, unless Prometheus Node monitoring thing already does this?
* fully IPFS-based, see [Roadmap](roadmap/) - on [Local Persistent Volumes](https://www.google.com/search?q=Kubernetes+Local+Persistent+Volumes)? With [sig-storage-local-static-provisioner](https://github.com/kubernetes-sigs/sig-storage-local-static-provisioner)
* [Longhorn](https://longhorn.io)?


Networking

* https://www.gsocket.io
* capture network traffic with `-net dump`, inspect `qemu-vlan0.pcap` with.. wireshark?
* learn details about `/etc/nsswitch.conf` and `/etc/resolv.conf`.. where's the "resolver"- in the libc? If "the Linux kernel doesn't care about DNS" and it's userspace libraries to do lookups, then what is https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/net/dns_resolver/dns_query.c?h=v5.6-rc5 for?
* replace `-net user` with a TUN/TAP network bridged to the host's https://wiki.syslinux.org/wiki/index.php?title=Development/Testing#TUN.2FTAP_network
* connect several VMs among themselves, using `-netdev socket` (or `-nic socket` or `-net socket`), see https://www.qemu.org/docs/master/system/net.html#connecting-emulated-networks-between-qemu-instances


Workstation

* what is https://github.com/containers/bubblewrap?
* https://wiki.archlinux.org/index.php/QEMU#virtio qemu graphical console with framebuffer (with Linux on top)
  `qemu-system-x86_64 -kernel /tmp/bzImage -append "" -initrd busybox-init-initrd.gz --enable-kvm -m 512 -nic none -vga virtio [-display sdl,gl=on]`
  but keyboard layout needs to be fixed (and font is very ugly);
  Ctrl-Alt-F makes it feel very real! ;)
* https://wiki.archlinux.org/index.php/intel_graphics
* Wayland
* VM that, pass through graphics card access


Physical (Bare Metal)

* support PXE booting in qemu
* Dracut? https://fedoramagazine.org/initramfs-dracut-and-the-dracut-emergency-shell/
  https://github.com/dracutdevs/dracut (also https://fedoraproject.org/wiki/Dracut)
* boot a NUC with it (through BIOS' PXE, or iPXE)
* consider  http://www.linuxfromscratch.org/blfs/view/svn/postlfs/firmware.html
  and https://01.org/linuxgraphics/downloads/firmware/
* boot an old laptop with it!  powertop and throttle CPU when not typing or touching screen or moving mouse?
* [import disk image to Google Cloud](https://cloud.google.com/compute/docs/import/import-existing-image),
  similarly to e.g. https://thekev.in/blog/2019-08-05-dockerfile-bootable-vm/index.html
  Automate this, and offer CI/CD?


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


Later (if ever)

* https://godarch.com?
* https://wiki.archlinux.org/index.php/intel_graphics
* OLD https://github.com/vorburger/cloud.labs.learn.study/blob/master/TODO.txt
