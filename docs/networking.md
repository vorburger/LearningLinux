# Networking

## Usage

`ifconfig` shows the (currently only) `inet6 addr`, which we can ping:

    / # ping fec0::5054:ff:fe12:3456

_TODO IPv4?  Route Default Gateway?_


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
