#!/usr/bin/bash
set -euox pipefail

if [[ -f /swap/swapfile ]]; then
  systemctl disable --now swap-swapfile.swap
  sed -i '/swap/d' /etc/fstab
  rm /swap/swapfile
  btrfs subvolume delete /swap
fi

pacman -S --needed --noconfirm cri-o kubelet kubeadm crictl kubectl yq nano

# https://wiki.archlinux.org/index.php/CRI-O#Storage
sed -i 's/driver = ""/driver = "btrfs"/' /etc/containers/storage.conf

# https://wiki.archlinux.org/index.php/Kubernetes#Configuration
rm -rf /var/lib/kubelet
btrfs subvolume create /var/lib/kubelet
echo "/dev/vda2 /var/lib/kubelet btrfs subvol=/var/lib/kubelet 0 0" >>/etc/fstab
# mount -t btrfs -o subvol=/var/lib/kubelet /dev/vda2 /var/lib/kubelet/

rm -rf /var/lib/containers
btrfs subvolume create /var/lib/containers
echo "/dev/vda2 /var/lib/containers btrfs subvol=/var/lib/containers 0 0" >>/etc/fstab
# mount -t btrfs -o subvol=/var/lib/containers /dev/vda2 /var/lib/containers/

# https://wiki.archlinux.org/index.php/Kubernetes#CRI-O
cp /etc/kubernetes/kubelet.env /etc/kubernetes/kubelet.env.original
echo "KUBELET_ARGS=--cni-bin-dir=/usr/lib/cni --cgroup-driver='systemd'" >/etc/kubernetes/kubelet.env

systemctl enable --now crio
crio-status info
crictl version
crictl info
crictl stats

systemctl enable kubelet
