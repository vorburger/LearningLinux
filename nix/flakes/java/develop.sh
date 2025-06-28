#!/usr/bin/env sh

# TODO How to avoid needing this script at all?!

# NB: This starts the user's $SHELL (which may not be Bash but e.g. Fish)
# in an *IMPURE* Nix devShell; which allows using binaries from the OS package manager etc.
# This is not reproducible - but convenient to be able to use one's dotfiles.
# It is only useful for testing the devShell interactively.
# Real builds should use the `package` script instead.

nix develop --command "$SHELL"
