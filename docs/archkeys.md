# Arch Linux Keys for Packaging Signing

https://wiki.archlinux.org/title/Pacman/Package_signing and
https://wiki.archlinux.org/title/DeveloperWiki:Package_signing have background.

https://gitlab.archlinux.org/archlinux/arch-boxes/-/issues/153#note_75956 points to
https://gitlab.archlinux.org/archlinux/archlinux-docker/#principles which explains:

_"NOTE: For Security Reasons, these images strip the pacman lsign key.
This is because the same key would be spread to all containers of the same
image, allowing for malicious actors to inject packages (via, for example,
a man-in-the-middle). In order to create an lsign-key run `pacman-key
--init` on the first execution, but be careful to not redistribute that
key."_


## Troubleshooting

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
