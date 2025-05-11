# ToDo

## Nix

1. https://github.com/enola-dev/enola/pull/1227
1. https://github.com/vorburger/vorburger-dotfiles-bin-etc as https://flox.dev/docs/tutorials/default-environment/
1. https://2025.nixcon.org, in CH; watch https://github.com/NixOS/org/issues/70

1. [NixOS](NixOS.md)
1. READ! Manual, Pills, ... from _Learning_ links at the bottom
1. https://github.com/nix-community/home-manager
1. nix-shell --pure without reading existing dotfiles seems PITA... so use a container!
1. https://nixos.org/manual/nix/stable/command-ref/new-cli/nix.html#examples
1. dotfiles: How to isolate from host? Then: Nano, [Starship](https://starship.rs/installing/#nix), ...
1. [`nix build`](https://nixos.org/manual/nix/stable/command-ref/nix-build.html)
1. sandbox? Explore.. try accessing file, and network via `curl` `set sandbox = true` in `/etc/nix/nix.conf`
1. `nix run` missing `./default.nix` what's that?
1. use https://nixos.org/manual/nix/stable/#sec-nix-shell in my scripts
1. https://nixos.wiki/wiki/Applications, notably LSP
1. write a `shell.nix` for `man nix-shell` (in https://github.com/vorburger/vorburger-dotfiles-bin-etc/)
1. containers build?
1. create a NixOS VM: `nixos-rebuild build-vm`, and then `./result/bin/run-*-vm`
1. install NixOS baremetal server, fully automated
1. install NixOS server on GCP GCE, using https://nixops.readthedocs.io/en/latest/?
1. create a simple bare minimal server config with a SSH container (as local VM & GCP GCE)
1. https://nixbuild.net/#pricing
1. https://github.com/nixos/hydra
1. [Nix related Actions on GitHub Marketplace](https://github.com/search?q=user%3Avorburger+nix&type=marketplace)
1. Local [Nixery](https://nixery.dev)
1. https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/services/games/minecraft-server.nix :)

## NixOS

1. Use https://github.com/nix-community/nixos-anywhere, which includes using https://github.com/nix-community/disko

1. VM with https://nix.dev/tutorials/nixos/nixos-configuration-on-vm ?

1. ssh with new key, not YK

1. VSC SSH remote - fix why it didn't work; just needs Node?

1. Custom ISO https://nix.dev/tutorials/nixos/building-bootable-iso-image and https://github.com/nix-community/nixos-generators#user-content-supported-formats

1. Read https://nixos-and-flakes.thiscute.world

1. https://nix.dev/install-nix#install-nix learn in Docker?

1. [dotfiles](https://github.com/vorburger/vorburger-dotfiles-bin-etc)! https://nix-community.github.io/home-manager/ ?

1. nixos-rebuild build-vm, and then ./result/bin/run-*-vm

1. Disable `useradd` - there was some option for this

1. Containers! https://nixos.wiki/wiki/Podman and https://nix.dev/tutorials/nixos/building-and-running-docker-images.html

1. https://github.com/nix-community/awesome-nix

1. Enable gc https://nixos-and-flakes.thiscute.world/nixos-with-flakes/other-useful-tips#reducing-disk-usage

1. Immutable https://wiki.nixos.org/wiki/Impermanence

1. Boot ISO to C64 ;) themed Blue Web Terminal! https://github.com/vorburger/cloudshell

1. How to build an even much more minimal VM? Without ANY userspace tools... JUST containers. Without even systemd? ;-)

       environment.systemPackages = with pkgs; [     # BusyBox provides a basic shell     busybox   ];

1. https://github.com/NixOS/nixpkgs/tree/master/pkgs/applications/virtualization ...

1. https://reproducible.nixos.org (funded?)

1. Speed up `install` - could it read from a cache, somehow?

1. UEFI: Try with VMM or directly with `qemu`, or fix in Boxes

1. NUC

1. https://kubenix.org

1. Speed up `install` - could it read from a cache, somehow?
