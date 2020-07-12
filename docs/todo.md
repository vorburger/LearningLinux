
* automate make run script copy the built /home/tux/linux-stable/linux out of the container using
  `podman cp kernel-dev:/home/tux/linux-stable/linux /tmp/`

* run under KVM instead of UML until UML crash fixed (optionally; also keep UML demo)

* fix UML crashing on host (outside of container) with "Aborted (core dumped)" using
  https://www.kernel.org/doc/Documentation/virtual/uml/UserModeLinux-HOWTO.txt

* fix UML crashing in-container (not on host) due to:

    Checking that ptrace can change system call numbers...ptrace: Operation not permitted
    check_ptrace : expected SIGSTOP, got status = 9_

* UML NB `ldd linux` - make statically linked (otherwise it may not work on an Ubuntu host, given build on Fedora?)
  by making script set `CONFIG_STATIC_LINK` in /home/tux/linux-stable/.config

* split `dev` from `kernel` containers
* make it possible to mount kernel sources from host (use `podman mount`; as UID mapping is PITA)
* use side car data volume container (see podman's Pod support..) to keep Kernel sources persistent
