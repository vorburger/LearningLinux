# Arch Linux Key Troubleshooting

* https://gitlab.archlinux.org/archlinux/archiso/-/issues/191 is an open issue

* https://gitlab.archlinux.org/archlinux/arch-boxes/-/issues/153 (from me) is because of above


In `index.docker.io/library/archlinux:latest` containers there are problems sometimes:

    STEP 1/3: FROM index.docker.io/library/archlinux:latest
    STEP 2/3: RUN pacman --noconfirm -Syu arch-install-scripts
    (...)
    downloading arch-install-scripts-26-1-any.pkg.tar.zst...
    checking keyring...
    downloading required keys...
    :: Import PGP key 139B09DA5BF0D338, "David Runge <dvzrv@archlinux.org>"? [Y/n]
    checking package integrity...
    :: File /var/cache/pacman/pkg/linux-api-headers-5.18.15-1-any.pkg.tar.zst is corrupted (invalid or corrupted package (PGP signature)).
    Do you want to delete it? [Y/n] error: linux-api-headers: signature from "Frederik Schwan <frederik.schwan@linux.com>" is unknown trust
    error: glibc: signature from "Frederik Schwan <frederik.schwan@linux.com>" is unknown trust

I tried things like this:

    RUN pacman-key --init
    RUN pacman --noconfirm -Syu archlinux-keyring

but they didn't really seem to help. I **think** (not 100%) sure simply rm the image in the end did the trick for me:

    podman image rm index.docker.io/library/archlinux:latest

Perhaps always `--pull-always` is best when using the archlinux base image?
