# ArchISO

See https://wiki.archlinux.org/title/Archiso and https://gitlab.archlinux.org/archlinux/archiso.


## Build archiso's releng

Rebuild the default ISO image:

    mkarchiso -v -w /tmp/archiso1 /usr/share/archiso/configs/releng/

    run_archiso -v -i out/archlinux*.iso

NB the `-v` was contributed to arch in https://bugs.archlinux.org/task/69142.


# Build my own distro's ISO with archiso

This is a custom distro to work on implementing [the Roadmap](../docs/roadmap):

For now, [pending the integration](https://gitlab.archlinux.org/archlinux/archiso/-/merge_requests?scope=all&utf8=%E2%9C%93&state=opened&author_username=vorburger)
of some [code on my `archiso` fork](https://github.com/archlinux/archiso/compare/master...vorburger:cloud-init-vorburger-full):

    git clone https://github.com/archlinux/archiso.git; cd archiso; git checkout cloud-init-vorburger-full; cd ..
    git clone https://github.com/vorburger/LearningLinux.git; cd LearningLinux/archlinux/iso

    rm -rf /tmp/newos*.iso /tmp/newos.work; mkarchiso -v -w /tmp/newos.work -o /tmp/ .

    ../../../archiso/scripts/cloud-init.sh

    ../../../archiso/scripts/run_archiso.sh -v -c cloud-init.iso -b -i /tmp/newos*.iso

    ssh -o StrictHostKeyChecking=no -o "UserKnownHostsFile /dev/null" -p 60022 localhost


## Using my own distro's ISO

Install the ISO on a new disk: _(TODO The `dinstall` [script was here](https://github.com/vorburger/LearningLinux/blob/9024aec2468659ff9eeee0b77f7e998132d2b7ac/archlinux/iso/airootfs/usr/local/sbin/dinstall).)

    dinstall /dev/sda

then boot from that disk:

    ../../bin/run-cloud-init.sh /tmp/newos*.iso.raw

