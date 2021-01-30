set -euo pipefail

qemu-system-x86_64 \
    -nodefaults -no-user-config \
    -enable-kvm  -cpu host  -m 2048  -smp 2 \
    -serial stdio  -nographic  -display none \
    -net nic -net user,hostfwd=tcp::60022-:22 \
    -drive "file=$1,format=raw,if=virtio" \
    -drive id=cdrom1,if=none,format=raw,media=cdrom,readonly=on,if=virtio,file=cloud-init.iso
