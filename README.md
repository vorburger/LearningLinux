Learning Linux Kernel Development
=================================

[`./run-qemu`](./run-qemu) builds a Linux Kernel `bzImage` in a container and starts it in a virtual machine
(using KVM, with QEMU; [enable virtualization](docs/setup-virtualization.md) first).
Currently, it will get up to, and crash at, where it needs a userland.

[`./run-uml`](./run-uml) builds a User Mode Linux Kernel image in a container and then starts it in user mode.
Currently, it will crash fairly early (and mess up your console).

[./run-dev](./run-dev) will run an interactive dev container to explore `[tux@kernel-dev ~]`.
Its root password is empty, so you can e.g. `sudo dnf install -y ..`, but it's (intentionally) ephemeral - script it! ;)

[./test.tcl](./test.tcl) automatically tests everything that's described above; run it after making any changes (and extend it when adding new features).

[docs/](docs/) has more background and details; including [TODO](docs/todo.md)s.

by [Michael Vorburger.ch](https://www.vorburger.ch)
