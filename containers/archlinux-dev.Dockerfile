FROM archlinux

RUN pacman --noconfirm -Syu

RUN pacman --noconfirm -S man-db man-pages

RUN ln -s /usr/lib/systemd/systemd /init

RUN passwd --delete root
