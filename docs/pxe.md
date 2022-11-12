# PXE

## TL;DR

To run a _proxy DHCP_ just for PXE booting, create a `dnsmasq.conf` file containing:

    interface=eno1
    dhcp-range=192.168.1.1,proxy

and then run it with (note the `192.168.1.100` IP, that's where a TFTP server must run on port 69):

    sudo dnsmasq --keep-in-foreground --no-daemon --log-queries --log-dhcp \
      --port=0 --dhcp-option=66,"192.168.1.100" --conf-file=dnsmasq.conf \
      --dhcp-match=set:efi64,option:client-arch,9 --dhcp-boot=tag:efi64,ipxe.efi

Note how (inspired [by here](https://github.com/poseidon/dnsmasq), but with server name and addres) we use
pairs of `--dhcp-match=set:XXX,... --dhcp-boot=tag:XXX,...` instead of using `--dhcp-option=66,"1.2.3.4"` (like
the single `next-server`, which is the DHCP Server-Name option 66, seen in ISC DHCP server configuration files).


## Background

Run [`dnsmasq`](https://thekelleys.org.uk/dnsmasq/doc.html), at home probably using [Proxy DHCP](https://wiki.archlinux.org/title/Dnsmasq#Proxy_DHCP),
and to [break the loop](https://ipxe.org/howto/chainloading) configure `dhcp-match` and `dhcp-boot` [like this](https://github.com/poseidon/dnsmasq)
using [`ipxe.efi`](http://boot.ipxe.org/ipxe.efi) (e.g. for ThinkPad, with UEFI PXE;
or [`undionly.kpxe`](http://boot.ipxe.org/undionly.kpxe) for BIOS PXE, with
`cp undionly.kpxe undionly.kpxe.0` [like here](https://github.com/poseidon/dnsmasq/blob/main/get-tftp-files)).

That last `dhcp-boot` can be a number of things, e.g. either one of:

* URL to a HTTP hosted text file of [an iPXE script](https://ipxe.org/scripting). These have to start with ("magic") `#!ipxe` 
  and then contain e.g. [`kernel`, `initrd`, `boot`](https://ipxe.org/cmd/kernel).
* Arch Linux Netboot: [Download](https://archlinux.org/releng/netboot/), [Wiki](https://wiki.archlinux.org/title/Netboot)
* [Sidero](https://www.sidero.dev/v0.5/getting-started/prereq-dhcp/)

On a (my) ThinkPad T460s getting the PXE firmware at boot is a confusing PITA;
it required setting UEFI only (not Legacy, or Mixed) and moving PCI LAN up before disk in the boot order, 
and disabling secure boot; takes some fiddling. Also seems needs an Ethernet with an active link?

It doesn't work over WiFi. (Although iPXE appears to have some WiFi support, untested; but perhaps
putting iPXE on disk and booting that from a regular disk bootloader to let it do PXE boot over WiFi could work?)

## dnsmasq for libvirt

Note that e.g. on a Fedora with KVM + libvirt, there is a `/var/lib/libvirt/dnsmasq/default.conf` 
which is the DHCP server for `interface=virbr0` which gives VMs IPs from `192.168.122.2` onwards;
this [is started by `libvirtd` for each virtual network](https://wiki.libvirt.org/page/Libvirtd_and_dnsmasq).

Note that this different from and unrelated to the `/usr/lib/systemd/system/dnsmasq.service`
which `systemctl status dnsmasq.service` shows to be disabled (at least on a Fedora Workstation 36).

There is also the default `/etc/dnsmasq.conf` which does not actually seem to be used,
according to `sudo lsof /etc/dnsmasq.conf`.

So we can run a `dnsmasq` on the `eno1` interface that's separate from all of the above.

## ToDo

1. Play with VMs instead of metal: Add required config to the `dnsmasq` that QEMU is already running for DHCP,
   and start QEMU with some options to launch a PXE client "firmware", instead of disk or Kernel directly;
   `qemu-system-x86_64 -boot order=n` maybe with `-device e1000,netdev=n1 -netdev user,id=n1,tftp=/path/to/tftp/files,bootfile=/pxelinux.0`, or
   `-kernel ipxe.lkrn` [as used here](https://wiki.archlinux.org/title/Netboot#Using_ipxe.lkrn)

1. Build one of those fat uber Kernels with an embedded initrd that can run entirely from RAM without loading a root FS.

1. Copy [this container](https://github.com/poseidon/dnsmasq) with `dnsmasq` and improve it by adding [`darkhttpd`](https://unix4lyfe.org/darkhttpd/)?



## References

* https://matchbox.psdn.io
* https://www.talos.dev/v1.2/talos-guides/install/bare-metal-platforms/matchbox/
* https://github.com/poseidon/dnsmasq
* https://wiki.archlinux.org/title/Dnsmasq
* https://wiki.archlinux.org/title/Preboot_Execution_Environment
* https://ipxe.org; NB https://ipxe.org/howto/chainloading
* https://wiki.archlinux.org/title/Syslinux#PXELINUX - _I don't really understand what the point of this is_
* https://github.com/danderson/netboot/tree/master/pixiecore looks neat, haven't tried it;
  [is not longer actively developed](https://github.com/danderson/netboot/blob/master/README.md)
* https://github.com/DongJeremy/pxesrv
* https://github.com/pojntfx/ipxebuilderd
