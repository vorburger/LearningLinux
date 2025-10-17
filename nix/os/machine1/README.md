# NixOS Machine #1

## VM

    nix shell nixpkgs#nixos-rebuild

    nixos-rebuild build-vm --flake .#machine1

    /nix/store/...-nixos-vm/bin/run-nixos-vm

Login as `vorburger` & `x` - whoa!

## NixOS

    nixos-rebuild switch --flake .#machine1

will run `nixos-rebuild build` etc. and switch the current OS.

    nom build .#nixosConfiguration.machine1.config.system.build.toplevel

will create `result/` which is useful for exploring output.
