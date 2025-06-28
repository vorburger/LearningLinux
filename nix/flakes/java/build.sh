#!/usr/bin/env bash
set -euo pipefail

if ! [ -x "$(command -v nix)" ]; then
  echo "Please first install Nix; see https://github.com/vorburger/LearningLinux/blob/develop/nix/docs/install.md"
  exit 255
fi

SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
cd "$SCRIPT_DIR"
nix develop --ignore-env --command "$SCRIPT_DIR/script.sh" "$@"

# PS: --ignore-env is to run the script in a "pure" environment
# (without any of the user's environment variables (e.g. PATH),
# for ensuring that binaries required by the script are in flake.nix!
