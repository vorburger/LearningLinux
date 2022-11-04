# Networking

## With systemd's `systemd-networkd` + `systemd-resolved` e.g. in archlinux

    networkctl
    networkctl status ens3cat

Note the `Network File`, e.g. `/etc/systemd/network/20-ethernet.network`.
(If it missed to get the gateway IP by DHCP, workaround it using
e.g. `ip route add default via 192.168.1.10 dev wlan0`, or add
a `Gateway=` to the `[Network]` of the the `*.network` file.)


## DNS in nested VMs

`resolvectl` DNS in nested VMs does not just work:

`systemctl status systemd-resolved` shows `Using degraded feature set TCP instead of UDP for DNS server 10.0.2.3.` (and UDP).

Somehow the "inner" DNS doesn't manage to speak to the "outer" one (double NAT issue?).

The easiest workaround is to use `resolvectl dns enp0s4 8.8.8.8`, made permanent with `DNS=8.8.8.8` in `[Network]` **AND** `UseDNS=false` in `[DHCP]` in a `/etc/systemd/network/1-ethernet.network`,  [lexically sorted earlier](https://superuser.com/a/1354974/66965) than the default configs in `/run/systemd/network` which are prefixed with `10-`.  _(TODO find a better permanent solution for this.)_

Using `-nic user,net=10.0.99.0/24` on qemu to have a separate network on the nested VM does not fix this (but is clearer).


## Without systemd, e.g. in busybox

### Usage

`ifconfig` shows our `inet6 addr`, which we can ping:

    / # ping fec0::5054:ff:fe12:3456

as well as an IPv4 (e.g. `10.0.2.15` obtained by DHCP from
[QEMU's Network Emulation](https://www.qemu.org/docs/master/system/net.html)), so we can also do:

    / # route
    / # cat /etc/resolv.conf
    / # ping -w 3 8.8.8.8
    / # ping -w google.com

This works because [`udhcp` runs `/usr/share/udhcpc/default.script`](https://udhcp.busybox.net/README.udhcpc)
which our build [copied from git.busybox.net](https://git.busybox.net/busybox/plain/examples/udhcp/simple.script).
Note that the message re. `/etc/network/if-up.d` is a red herring (that's probably from `ifup`, not from `udhcp`).


### Background

With `qemu* ... -nic none`, we can see that `ls /sys/class/net/`
(and `ifconfig -a`, under our _busybox_) shows that we only have a `lo`
(and perhaps `sit0`, for IPv6 tunneling through IPv4), but no `eth0`, yet.

With `qemu* ... -nic user`, we'll see an `eth0`, but (on our _busybox_)
`ifup eth0` fails with `ifup: can't open '/etc/network/interfaces': No such file or directory`.
We can fix this with `echo auto eth0 >/etc/network/interfaces` and `echo iface eth0 inet dhcp >>/etc/network/interfaces` and then retry `ifup -nv eth0` which shows what `ifup eth0` will do:

    run-parts /etc/network/if-pre-up.d
    ip link set eth0 up
    udhcpc -R -n -p /var/run/udhcpc.eth0.pid -i eth0
    run-parts /etc/network/if-up.d

## References

* https://www.qemu.org/docs/master/system/net.html
* https://wiki.qemu.org/Documentation/Networking
* https://zwischenzugs.com/2018/06/08/anatomy-of-a-linux-dns-lookup-part-i/
