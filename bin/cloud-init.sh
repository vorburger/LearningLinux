#!/usr/bin/env bash
#
# Copyright (C) 2020 Michael Vorburger.ch <mike@vorburger.ch>
#
# SPDX-License-Identifier: GPL-3.0-or-later
#
# Simple script creating correct cloudinit.iso from current UID & PubKey.
# See https://wiki.archlinux.org/index.php/Cloud-init.

set -euo pipefail

print_help() {
    local usagetext
    IFS='' read -r -d '' usagetext <<EOF || true
Usage:
    cloud-init.sh [options]

Options:
    -k [key]        key filter
    -h              print help

Example:
    Creates 'cloud-init.iso', using all public keys availabe via 'ssh-add -L'
    $ cloud-init.sh

    Creates 'cloud-init.iso' using public keys from 'ssh-add -L' which contain "xoxo"
    $ cloud-init.sh -k xoxo

EOF
    printf '%s' "${usagetext}"
}

filter=''
if (( ${#@} > 0 )); then
    while getopts 'k:h' flag; do
        case "$flag" in
            k)
                filter="$OPTARG"
                ;;
            h)
                print_help
                exit 0
                ;;
            *)
                printf '%s\n' "Error: Wrong option. Try 'cloud-init.sh -h'."
                exit 1
                ;;
        esac
    done
fi


userdata="$(mktemp -t user-data.XXXXXXXXXX)"

printf '#cloud-config\nusers:\n  - name: %s\n    ssh_authorized_keys:\n%s\n' "$USER" "$(ssh-add -L | grep "$filter" | sed -E 's/^(.*)/      - \1/g')" > "$userdata"

cloud-localds cloud-init.iso "$userdata"

cat -- "$userdata"
rm -- "$userdata"
printf '\n---\n%s\n' "cloud-init.iso successfully created (use it e.g. with run_archiso.sh -c cloud-init.iso)"
