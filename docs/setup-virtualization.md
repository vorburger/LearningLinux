To install KVM & QEMU and enable virtualization on Fedora:

    dnf group install --with-optional virtualization
    systemctl start libvirtd
    systemctl enable libvirtd
    sudo usermod -a -G libvirt $(whoami)
