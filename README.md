Learning Linux Kernel Development
=================================

[`./build`](./build) builds a Linux Kernel `bzImage` (inside a container, it's just easier for dependencies)
and a userland demo image with minimal "hello, world" `/init` static binary runnable in a `FROM scratch` demo container,
as well as a `busybox` container which has an `/init` symlink to `/bin/sh`.

[`./run-qemu hello`](./run-qemu) starts this Kernel in a virtual machine
(using KVM, with QEMU; [enable virtualization](docs/setup-virtualization.md) first),
using our own `hello` demo as initrd.

[`./run-qemu busybox-init`](./run-qemu) starts this Kernel in a virtual machine
using the busybox container image as initrd (quit it using `poweroff -f`).  Also see [networking](docs/networking.md)).

You can use any Docker Container image as User Land, see [image2initrd](image2initrd).

[`./run-qemu-syslinux /tmp/bzImage hello | busybox-init`](./run-qemu-syslinux) then starts this Kernel and the hello container initrd in a virtual machine by building a real disk image with a SYSLINUX bootloader.  (Whereas `run-qemu` uses `qemu* -kernel -initrd`.)

The `/tmp/bzImage-busybox-init.img` disk image can be written to a USB key (e.g. using `dd`, or, easier, GNOME Disks), and will boot on bare metal.

[`./run-uml`](./run-uml) builds a User Mode Linux Kernel image in a container and then starts it in user mode.
_Currently, the UML kernel will crash fairly early (and mess up your console)._

[./run-dev](./run-dev) will run an interactive dev container to explore `[tux@kernel-dev ~]`.
Its root password is empty, so you can e.g. `sudo dnf install -y ..`, but it's (intentionally) ephemeral - script it! ;)

[./test.tcl](./test.tcl) automatically tests everything that's described above; run it after making any changes (and extend it when adding new features).

[docs/](docs/) has more background and details; including [TODO](docs/todo.md)s.

by [Michael Vorburger.ch](https://www.vorburger.ch)
