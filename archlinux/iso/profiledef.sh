#!/usr/bin/env bash
# shellcheck disable=SC2034

iso_name="newos"
iso_label="NEWOS_$(date +%Y%m)"
iso_publisher="Michael Vorburger.ch <http://www.vorburger.ch>"
iso_application="New OS, see https://github.com/vorburger/LearningLinux/blob/develop/docs/roadmap/readme.md"
iso_version="$(date +%Y.%m.%d)"
install_dir="arch"
bootmodes=('bios.syslinux.mbr' 'bios.syslinux.eltorito' 'uefi-x64.systemd-boot.esp' 'uefi-x64.systemd-boot.eltorito')
arch="x86_64"
pacman_conf="pacman.conf"
airootfs_image_tool_options=('-b' '1M')
file_permissions=(
  ["/etc/shadow"]="0:0:400"
)
