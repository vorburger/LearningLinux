FROM fedora-updated

RUN sudo dnf group install -y "Development Tools"
RUN sudo dnf install -y git nano findutils file xz ncurses-devel bison flex elfutils-libelf-devel openssl-devel bc hostname glibc-devel.i686 glibc-static.i686 glibc-static

# U6aMy0wojraho is hash of the empty string; this permits using sudo (just type Enter when asked for the password)
RUN useradd tux -G wheel -p U6aMy0wojraho
WORKDIR /home/tux
USER tux
