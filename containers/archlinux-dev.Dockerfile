FROM archlinux

RUN pacman --noconfirm -Syu

RUN pacman --noconfirm -S arch-install-scripts man-db man-pages

RUN ln -s /usr/lib/systemd/systemd /init
