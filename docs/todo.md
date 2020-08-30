* build much smaller kernel than `x86_64_defconfig` (but not as small as `tinyconfig`, which doesn't work)

* make script set some "Kernel Hacking" options in /home/tux/linux-stable/.config as per
  https://medium.com/@daeseok.youn/prepare-the-environment-for-developing-linux-kernel-with-qemu-c55e37ba8ade

* fix UML crashing on host (outside of container) with "Aborted (core dumped)" using
  https://www.kernel.org/doc/Documentation/virtual/uml/UserModeLinux-HOWTO.txt

* UML NB `ldd linux` - make statically linked (otherwise it may not work on an Ubuntu host, given build on Fedora?)
  by making script set `CONFIG_STATIC_LINK` in /home/tux/linux-stable/.config

* fix UML crashing in-container (not on host) due to (it may be because of `tinyconfig`?):

    Checking that ptrace can change system call numbers...ptrace: Operation not permitted
    check_ptrace : expected SIGSTOP, got status = 9_

* split `dev` from `kernel` containers
* make it possible to mount kernel sources from host (use `podman mount`; as UID mapping is PITA)
* use side car data volume container (see podman's Pod support..) to keep Kernel sources persistent
