# Networking

## Usage

`ifconfig` shows the (currently only) `inet6 addr`, which we can ping:

    / # ping fec0::5054:ff:fe12:3456

For some reason _(to be investigated; likely missing `/etc/network/if-up.d` ?)_
the IPv4 address obtained by DHCP is not automatically assigned out of the box in Busybox,
so we currently have to manually do the following to get fully working networkig set up:
(knowing [QEMU's Network Emulation](https://www.qemu.org/docs/master/system/net.html))

    / # ifconfig eth0 10.0.2.15
    / # ping -w 3 10.0.2.15
    / # route add default gw 10.0.2.2 eth0
    / # ping -w 3 8.8.8.8
    / # echo nameserver 8.8.8.8 >/etc/resolv.conf
    / # ping -w google.com


## Background

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
