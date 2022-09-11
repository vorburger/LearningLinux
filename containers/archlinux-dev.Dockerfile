FROM index.docker.io/library/archlinux:latest

RUN pacman --noconfirm -Syu man-db man-pages

RUN ln -s /usr/lib/systemd/systemd /init

RUN passwd --delete root
