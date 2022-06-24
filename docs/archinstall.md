# Arch Linux with archinstall

This is for a "normal install", using `archinstall` (there is also "[my own distro](archlinux.md)").

## Steps

1. [Download ISO](https://archlinux.org/download/)
1. boot ISO, either on Metal, or e.g. in Boxes
1. `passwd` to set a temporary password for archiso
1. `networkctl status` to get IP ([see also here](https://github.com/vorburger/LearningLinux/blob/develop/docs/networking.md))
1. `scp archinstall/* root@192.168.x.x:/root`
1. `ssh -t root@192.168.x.x /root/install.sh`
1. `ssh vorburger@192.168.x.x`
   Password is "x" (see [user_credentials.json](user_credentials.json))
   (NB: IP may change! With Boxes, it's +1. Else login on console again to get it, as qabove.)


## Troubleshooting

* archinstall.lib.exceptions.SysCallError: ['/usr/bin/blkid', '-p', '-o', 'export', '/dev/sr0'] exited with abnormal exit code [256]: This seems to just goes away after one retries once again.


## References

* https://wiki.archlinux.org/title/Installation_guide
* https://wiki.archlinux.org/title/Install_Arch_Linux_via_SSH
* https://wiki.archlinux.org/title/Archinstall


## ToDo

see [TODO](todo.md)

