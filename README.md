Learning Linux Kernel Development
=================================

1. [`./build`](./build) builds a Linux Kernel `bzImage` (inside a build container, it's just easier for dependencies)
and userland demo images such as: (You can use any Docker Container image as User Land, see [image2initrd](image2initrd),
as long as it has an `/init`).

   * hello: a minimal "hello, world" `/init` static binary runnable in a `FROM scratch` demo container
   * busybox-init: a `busybox`-based container with _bash_ as _init_ and working networking

1. [`./run-qemu hello`](./run-qemu) starts this Kernel in a virtual machine
(using KVM, with QEMU; [enable virtualization first](docs/setup-virtualization.md)),
with an _initrd_ containing our [`hello`](containers/src/hello.c) demo.

1. [`./run-qemu busybox-init`](./run-qemu) starts this Kernel in a virtual machine
using the busybox container image plus our own [`init`](containers/busybox-init)
as initrd.  You can quit it using `poweroff -f`.  Also see [networking](docs/networking.md).

1. [`./run-qemu-syslinux hello | busybox-init`](./run-qemu-syslinux) builds a disk image with SYSLINUS bootloader, and starts virtual machine.
(Whereas `run-qemu` uses `qemu* -kernel -initrd`.)

1. The `/tmp/bzImage-busybox-init.img` disk image can be written to a USB key (e.g. using `dd`, or, easier, GNOME Disks), and will boot on bare metal.

1. [`./run-dev-container`](./run-dev-container) will run an interactive dev container to explore `[tux@kernel-dev ~]`.
Its root password is empty, so you can e.g. `sudo dnf install -y ..`, but it's (intentionally) ephemeral - script it! ;)

1. [`./test.tcl`](./test.tcl) automatically tests everything that's described above; run it after making any changes (and extend it when adding new features).

[`docs/`](docs/) has more background and details; **including a [Roadmap](docs/roadmap)** and [TODO](docs/todo.md)s.
[Architecture](docs/architecture.md) (future, TBD) further describes what's what in this repo.

[`archlinux`](archlinux/) has my [Arch Linux](https://archlinux.org) based distro.

by [Michael Vorburger.ch](https://www.vorburger.ch)
