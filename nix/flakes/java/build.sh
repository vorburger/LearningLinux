#!/usr/bin/env bash
set -euo pipefail

# This script is just for convenience... it's not really needed for anyone familiar with Nix.

if ! [ -x "$(command -v nix)" ]; then
  echo "Please first install Nix; see https://github.com/vorburger/LearningLinux/blob/develop/nix/docs/install.md"
  exit 255
fi

SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
cd "$SCRIPT_DIR"
nix build .#hello

result/bin/hello
