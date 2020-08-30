Learning Linux Kernel Development
=================================

[`./build`](./build) builds a Linux Kernel `bzImage` (inside a container, it's just easier for dependencies)
and a userland demo image with minimal "hello, world" `/init` static binary runnable in a `FROM scratch` demo container,
as well as a `busybox` container which has an `/init` symlink to `/bin/sh`.

[`./run-qemu hello | busybox-init`](./run-qemu) and starts this Kernel in a virtual machine
(using KVM, with QEMU; [enable virtualization](docs/setup-virtualization.md) first),
using either our `hello` demo or the busybox container image as initrd.
You can use any Docker Container image as User Land, see [image2initrd](image2initrd).

[`./run-uml`](./run-uml) builds a User Mode Linux Kernel image in a container and then starts it in user mode.
_Currently, the UML kernel will crash fairly early (and mess up your console)._

[./run-dev](./run-dev) will run an interactive dev container to explore `[tux@kernel-dev ~]`.
Its root password is empty, so you can e.g. `sudo dnf install -y ..`, but it's (intentionally) ephemeral - script it! ;)

[./test.tcl](./test.tcl) automatically tests everything that's described above; run it after making any changes (and extend it when adding new features).

[docs/](docs/) has more background and details; including [TODO](docs/todo.md)s.

by [Michael Vorburger.ch](https://www.vorburger.ch)
