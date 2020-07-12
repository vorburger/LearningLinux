FROM fedora-updated

RUN sudo dnf group install -y "Development Tools"
RUN sudo dnf install -y git ncurses-devel bison flex elfutils-libelf-devel openssl-devel

RUN useradd tux
WORKDIR /home/tux
USER tux

RUN git clone git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git
