# Architecture

_TODO Make this the repo's root README, once this is actually fully implemented and everything adapted._

## Linux Distro Tools

`arch-install` (and similar future scripts) create the root FS in a directory on the host.

`run-dir` runs a directory with a root FS (including a Kernel+initrd in its `/boot`) with KVM.

`build-tgz` _(TBD)_ builds a userland root filesystem from a `Dockerfile`[^containerfile].
We prepare it in `/mnt`, to separate it from the build container to avoid[^hostfs] conflicts,
and then export that as a `tgz`. This cannot be booted on bare metal. (This tool runs rootless[^root].)
__This is a PITA; see e.g. [archlinux-pacstrap.Dockerfile](../containers/archlinux-pacstrap.Dockerfile).__

`run-tgz` _(TBD)_ extracts _(TODO cached)_ a `tgz`'s Kernel+initrd from `/boot` to 2 local files,
and the remaining files to a disk image (without boot loader), and runs this using `qemu -kernel ... -initrd ...`.
(This tool runs rootless[^root].)

`build-syslinux-bios` _(TBD)_ converts _(TODO cached)_ a `tgz` to a disk image with Syslinux for BIOS as the boot loader. This image can then be booted on bare metal or in a VM. (This tool requires root[^root].)

`run-bios` _(TBD)_ runs a disk image with a BIOS launching a boot loader in a KVM VM.

`build-efistub` _(TBD)_ converts _(TODO cached)_ a `tgz` to a disk image with an ESP[^ESP].

`run-uefi` _(TBD)_ runs a disk image with an ESP[^ESP] with UEFI in a KVM VM.

_TODO Introduce a [Makefile like this](https://github.com/iximiuz/docker-to-linux/blob/master/Makefile) with targets for each command above, and respective dependencies, so that e.g. `make run xxx` builds and runs.
(Or use `bazel` for this? Or start `be`?)_

## Root Tools

`virt ...` runs the remaining arguments inside a isolated VM.
It can launc a default lightweight fast starting one, or your custom kind of VM built using the tools above.
This VM has access to all files under the current working directory of the host on a `/work` mount,
but none outside of it. This is a safer alternative to `sudo` and non-rootless containers.
_TODO Study [systemd-machined](https://www.freedesktop.org/software/systemd/man/systemd-machined.service.html#)
and [podman machine](https://docs.podman.io/en/latest/markdown/podman-machine.1.html); also note
the (now deprecated) [boot2podman](https://github.com/boot2podman/boot2podman)._

`suco ...`, like `sudo`, runs the remaining arguments inside a `--privileged --cap-add SYS_ADMIN` container.
_(TODO This may never get implemented. As far as I understand, this is basically inherently insecure, by design?)_

_TODO Once implemented, and root checks are added to start of the tool, both requiring as well as informing users when not needed, remove the "This tool runs rootless / requires root" doc above.)_


## File Formats

* `tgz` is the `/mnt` directory from a container image (`docker export`, not `save`).
  It contains a Kernel and `initrd` in `/boot`, and a "userland" in `/`.
  This is not a "disk" or a "partition" nor a "filesystem".


## Inspirations

* https://iximiuz.com/en/posts/from-docker-container-to-bootable-linux-disk-image/
* https://github.com/iximiuz/docker-to-linux
* https://github.com/linka-cloud/d2vm


## Footnotes

[^containerfile]: Or `Containerfile`, which is
  [AKA](https://github.com/containers/buildah/issues/1853) `Dockerfile`, but
  [not yet very well known](https://meta.stackoverflow.com/questions/407966/generalize-dockerfile-to-containerfile-for-now-and-the-future).

[^hostfs]: In a container, directories such as `/dev` and `/proc` and `/sys` or `/run` and
  some files in `/etc` are set-up by the container runtime, which would interfere with building
  a clean new userland root filesystem.

[^root]: Rootless tools do not require `sudo` to run as `root`. They CAN start rootless (!) containers or VMs.
  Rootful tools however require root, and cannot run in rootless containers. We can run them either:
  (1) on the host  using `sudo ...`, or
  (2) in a `--privileged --cap-add SYS_ADMIN` container using `suco ...`, or
  (3) in a VM using `virt`.

[^ESP]: EFI (Extensible Firmware Interface) system partition, or ESP; see e.g. [Wikipedia's] (https://en.wikipedia.org/wiki/EFI_system_partition) or [ArchLinux's](https://wiki.archlinux.org/title/EFI_system_partition) descriptions.
