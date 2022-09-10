#!/usr/bin/env bash
set -euox pipefail

# TODO Add --silent after https://github.com/archlinux/archinstall/issues/1113 is fixed
archinstall --config user_configuration.json --disk-layout user_disk_layout.json --creds user_credentials.json

reboot now
