# ToDo

## Nix

1. https://2025.nixcon.org, in CH; watch https://github.com/NixOS/org/issues/70

1. How to upgrade `nix` in Determinate?

1. `nixfmt` via `flake.nix` in this directory!

1. https://github.com/utensils/mcp-nixos

1. https://github.com/numtide/blueprint
   or https://github.com/tgirlcloud/nix-templates
   or https://flake.parts
   and https://github.com/nix-community/templates

1. https://mynixos.com

1. Combine https://nix.dev/tutorials/first-steps/reproducible-scripts
   with https://nix.dev/tutorials/first-steps/declarative-shell

1. https://devenv.sh, or https://github.com/numtide/devshell, or ...

1. https://github.com/nix-community/nix-direnv
   instead of https://github.com/nix-community/lorri

1. https://github.com/xzfc/cached-nix-shell

1. Try https://garnix.io ? Or https://hercules-ci.com, or https://www.cachix.org, etc.

1. https://github.com/nix-community/awesome-nix

1. https://github.com/google/google-java-format with `flake.nix` from https://zero-to-nix.com/start/init-flake/

1. GitHub Action to build e.g. `flake1`; see [Nix related Actions on GitHub Marketplace](https://github.com/search?q=nix&type=marketplace)
    1. Caching? E.g. Nix package themselves, and Maven or Bazel etc.
       * https://www.cachix.org ?
       * https://github.com/DeterminateSystems/magic-nix-cache costs ;(

1. DevContainer from Flake

1. `enola.git/flake.nix`
    1. Add to https://github.com/NixOS/nixos-search/blob/main/flakes/manual.toml
    1. Distribute on https://flakehub.com/flakes with https://github.com/DeterminateSystems/flakehub-push

1. How to manage the Nix user profile declarative instead of imperative?

1. https://nixos.wiki/wiki/Visual_Studio_Code#Creating_development_environments_using_nix-shell

1. https://github.com/numtide/treefmt-nix

1. https://github.com/enola-dev/enola/pull/1227
1. https://github.com/vorburger/vorburger-dotfiles-bin-etc as https://flox.dev/docs/tutorials/default-environment/

1. What's the difference between _packages_ and _apps_ e.g. on https://flakehub.com/flake/0x5a4/nand2tetris-flake?view=outputs

1. [NixOS](NixOS.md)
1. READ! Manual, Pills, ... from _Learning_ links at the bottom
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
1. Local [Nixery](https://nixery.dev)
1. https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/services/games/minecraft-server.nix :)

## NixOS

1. Try https://github.com/Mic92/nixos-shell

1. Use https://github.com/nix-community/nixos-anywhere, which includes using https://github.com/nix-community/disko;
   note https://github.com/nix-community/nixos-anywhere/blob/main/docs/howtos/no-os.md

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

1. https://github.com/ibizaman/selfhostblocks (from https://awesome-selfhosted.net/platforms/nix.html)

1. https://github.com/oddlama/nix-topology

1. https://github.com/ryantm/agenix
