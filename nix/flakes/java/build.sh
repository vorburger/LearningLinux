#!/usr/bin/env bash
set -euo pipefail

# TODO Check if "nix" is installed, and if not, print a message how to install it.

SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"

nix develop "$SCRIPT_DIR" --ignore-env --command "$SCRIPT_DIR/script.sh" "$@"

# PS: --ignore-env is to run the script in a "pure" environment
# (without any of the user's environment variables (e.g. PATH),
# for ensuring that binaries required by the script are in flake.nix!
