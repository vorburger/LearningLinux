# LVM

## Concepts

* PVs (Physical Volumes) are full disk devices, or just partitions, or loopback files.
* VGs (Volume Groups) are virtual groups of PVs.
* LVs (Logical Volumes) reside in VGs. They are block devices, and are FS formatted.

PEs (Physical Extents) are the smallest contiguous extents in PVs assigned to LVs.

## Introduction 101 Demo

Unless you have spare physical disks, let's create 2 loopback devices, to illustrate:

    # truncate --size=1G /var/loop0.img
    # truncate --size=1G /var/loop1.img
    # file /var/loop0.img /var/loop1.img

    # modprobe loop
    # mknod -m640 /dev/loop0 b 7 0
    # mknod -m640 /dev/loop0 b 7 1
    # losetup /dev/loop0 --nooverlap --show /var/loop0.img
    # losetup /dev/loop1 --nooverlap --show /var/loop1.img
    # losetup --all --list

Now let's create x2 PVs:

    # lsblk
    # lvmdiskscan
    # pvcreate -v /dev/loop0 /dev/loop1
    # file /var/loop0.img /var/loop1.img
    # pvs

Now let's create a VG, and initially use only 1 of our PVs:

    # vgcreate -v vg0 /dev/loop0
    # vgdisplay -v vg0
    # vgs

Now let's create a LV:

    # lvcreate --size 100M --name lv1 vg0
    # lvs

This LV is now available as the `/dev/vg0/lv1` block device, and we can use it like any other, to format it, mount it, and then writing 2 files which fit on it:

    # mkfs.ext4 -v -L lv1 -F /dev/vg0/lv1
    # mkdir /mnt/lv1
    # mount /dev/vg0/lv1 /mnt/lv1
    # echo "hello, world" >/mnt/lv1/hello.txt
    # dd if=/dev/urandom of=/mnt/lv1/big.data bs=1M count=80
    # df -h /mnt/lv1

If we now write another big file to it, that will obviously fail with `No space left on device`. But what we can do with LVM is resize the LV, given that we still have space on our (first) PV, and then write a much bigger file to it:

    # lvresize --size 1000M --resizefs vg0/lv1
    # dd if=/dev/urandom of=/mnt/lv1/bigger.data bs=1M count=800
    # df -h /mnt/lv1

If we need even more space, we can extend the LV using our 2nd (virtual, here) drive:

    # vgextend vg0 /dev/loop1
    # lvresize --size 1500M --resizefs vg0/lv1
    # df -h /mnt/lv1
    # dd if=/dev/urandom of=/mnt/lv1/more.data bs=1M count=400

What's fun is that if we only need space that fits on the 2nd new PV,
we could get rid of the 1st original one - without loosing any data:

    # rm /mnt/lv1/more.data /mnt/lv1/bigger.data
    # lvresize --size 500M --resizefs vg0/lv1
    # pvmove /dev/loop0
    # vgreduce vg0 /dev/loop0

To clean-up completely, let's entirely remove PVs and loopback mounts and image files:

    # umount /mnt/lv1
    # lvremove vg0/lv1
    # vgchange -a n vg0
    # vgremove vg0
    # pvremove /dev/loop0
    # pvremove /dev/loop1
    
    # losetup --detach /dev/loop0
    # losetup --detach /dev/loop1
    # rm /dev/loop0
    # rm /dev/loop1
    # rm /var/loop0.img
    # rm /var/loop1.img

## Configuration

    /etc/lvm/lvm.conf

    systemctl status lvm2-monitor.service

## Caching

TODO https://en.wikipedia.org/wiki/Dm-cache
 and https://wiki.archlinux.org/title/LVM#Cache
 and https://man7.org/linux/man-pages/man7/lvmcache.7.html

TODO How would one _monitor_ this to see how effective is?

## Striping

TODO https://www.youtube.com/watch?v=_dsHWq_MuUo

## Alternatives

Both BTRFS and ZFS offer similar _logical volume management,_
and [Wikipedia lists other options](https://en.wikipedia.org/wiki/Logical_volume_management).

## Background

* https://wiki.archlinux.org/title/LVM

## TODO

1. Test filesystem size overheads
1. `lvmthin` Thin Pools, `lvcreate --thin --thinpool --virtualsize`. Try --errorwhenfull on `lvcreate`
1. `lvmvdo` for compression
1. Caching
1. Striping
1. `pvscan` as on https://www.linuxsysadmins.com/moving-a-volume-group-from-server-to-server/
1. `vgchange`
1. `lvchange`
