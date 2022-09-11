#!/usr/bin/env fish

# TODO What's Fish's equivalent of Bash's "set -euox pipefail" to fail on error? (ignore other options)
# There isn't?!?!?!?  https://github.com/fish-shell/fish-shell/issues/510
# This does not work...
function failuuure --on-event fish_posterror
  echo "#fail"
end

# TODO Single line!
set GOME (realpath (dirname (status --current-filename)))
source $GOME/lib.fish

download https://geo.mirror.pkgbuild.com/images/latest/Arch-Linux-x86_64-basic.qcow2
# TODO "assert" Arch-Linux-x86_64-basic.qcow2 exists, else fail
