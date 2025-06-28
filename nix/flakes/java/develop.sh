#!/usr/bin/env sh

if ! [ -x "$(command -v nix)" ]; then
  echo "Please first install Nix; see https://github.com/vorburger/LearningLinux/blob/develop/nix/docs/install.md"
  exit 255
fi

# TODO How to avoid needing this script at all?!

# NB: This starts the user's $SHELL (which may not be Bash but e.g. Fish)
# in an *IMPURE* Nix devShell; which allows using binaries from the OS package manager etc.
# This is not reproducible - but convenient to be able to use one's dotfiles.
# It is only useful for testing the devShell interactively.
# Real builds should use the `package` script instead.

SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"

nix develop "$SCRIPT_DIR" --command "$SHELL"
