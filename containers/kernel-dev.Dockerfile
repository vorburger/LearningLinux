FROM fedora-updated

RUN sudo dnf group install -y "Development Tools"
RUN sudo dnf install -y git ncurses-devel bison flex elfutils-libelf-devel openssl-devel

