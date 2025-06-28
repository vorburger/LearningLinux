# ToDo

## Nix

1. Turn [README](README.md) into a slide deck? Make a YouTube video?? :)

1. https://2025.nixcon.org, in CH; watch https://github.com/NixOS/org/issues/70
   - How to get `nix develop` to respect `$SHELL` ? (Both directly and WITH `direnv` and `nix-direnv`.)
   - All the open `TODO` in the `flake.nix` etc. files
   - ... the rest here! ;)

1. Nix language server `nil` via `flake.nix` in this directory!
1. Formatting with https://github.com/numtide/treefmt-nix#flake-parts

1. Run `nix flake check` ... via https://github.com/cachix/git-hooks.nix?

1. https://devenv.sh, or https://github.com/numtide/devshell, or ...

1. DevContainer
1. Container Dev Env
   - Base image?
   - https://github.com/DeterminateSystems/nix-installer#in-a-container
1. Container https://github.com/NixOS/templates/blob/master/simple-container/flake.nix

1. GitHub Action to build e.g. `flake1`; see [Nix related Actions on GitHub Marketplace](https://github.com/search?q=nix&type=marketplace)
    1. https://github.com/DeterminateSystems/nix-installer#as-a-github-action
    1. Caching? E.g. Nix package themselves, and Maven or Bazel etc.
       - https://www.cachix.org ?
       - https://github.com/DeterminateSystems/magic-nix-cache costs ;(

1. `enola.git/flake.nix` https://github.com/enola-dev/enola/pull/1227
    1. Add to https://github.com/NixOS/nixos-search/blob/main/flakes/manual.toml
    1. Distribute on https://flakehub.com/flakes with https://github.com/DeterminateSystems/flakehub-push

1. How to auto-update - does Dependabot and/or Renovate dig Nix?!

1. Use https://github.com/DeterminateSystems/flake-checker ?

1. Use another formatter instead? E.g. https://github.com/kamadorueda/alejandra or https://github.com/NixOS/nixfmt/

1. Formatting in VSC with https://github.com/isbecker/treefmt-vscode via https://github.com/numtide/treefmt#ide-integration needs `treefmt.toml` instead of `treefmt.nix`, and `treefmt` on PATH; see https://github.com/numtide/treefmt-nix/issues/375.

1. Formatting with Git Hook using https://github.com/cachix/git-hooks.nix ... but that needs contributing treefmt to https://github.com/cachix/git-hooks.nix#nix-1

---

1. https://github.com/numtide/blueprint
   or https://github.com/tgirlcloud/nix-templates
   **or https://flake.parts**
   and https://github.com/nix-community/templates

1. Set-up https://github.com/utensils/mcp-nixos for this project!

1. https://github.com/nix-community/nix-direnv WITH `nix develop --command "$SHELL"`
   instead of https://github.com/nix-community/lorri
1. https://marketplace.visualstudio.com/items?itemName=mkhl.direnv
1. https://nixos.wiki/wiki/Visual_Studio_Code#Creating_development_environments_using_nix-shell

---

1. Adopt https://github.com/astro/deadnix ?

1. Adopt https://github.com/oppiliappan/statix ?

1. TODO What is "..." in outputs = { self, nixpkgs,...  }: used for?

1. Mix & match and grab newer protoc

1. How to upgrade `nix` in Determinate?

1. `ssh mac` for Multiplatform ... with flake-utils, as in e.g. https://github.com/NixOS/templates/blob/master/typescript/pnpm/flake.nix

1. https://github.com/xzfc/cached-nix-shell or try https://garnix.io ? Or https://hercules-ci.com, or https://www.cachix.org, etc. Or do I not need any of this with https://determinate.systems/flakehub/ ?

1. https://github.com/google/google-java-format with `flake.nix` from https://zero-to-nix.com/start/init-flake/

1. How to manage the Nix user profile declarative instead of imperative? Have a `flake.nix` in my https://github.com/vorburger/vorburger-dotfiles-bin-etc, for the base dev environment, with https://nix-community.github.io/home-manager/options.xhtml for something like (but without using) https://flox.dev/docs/tutorials/default-environment/. With [Starship](https://starship.rs/installing/#nix).

1. https://github.com/nix-community/awesome-nix

1. What's the difference between _packages_ and _apps_ e.g. on https://flakehub.com/flake/0x5a4/nand2tetris-flake?view=outputs

1. READ! Manual, Pills, ... from _Learning_ links at the bottom
1. sandbox? Explore.. try accessing file, and network via `curl` `set sandbox = true` in `/etc/nix/nix.conf`
1. use https://nixos.org/manual/nix/stable/#sec-nix-shell in my scripts
1. https://nixos.wiki/wiki/Applications, notably LSP
1. https://nixbuild.net/#pricing
1. https://github.com/nixos/hydra
1. Local [Nixery](https://nixery.dev)
1. https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/services/games/minecraft-server.nix :)

1. Lazy Trees?
   - https://determinate.systems/posts/changelog-determinate-nix-352/
   - https://determinate.systems/posts/changelog-determinate-nix-366/

## NixOS

1. [NixOS](docs/NixOS.md)

1. create a NixOS VM: `nixos-rebuild build-vm`, and then `./result/bin/run-*-vm`
1. install NixOS baremetal server, fully automated
1. install NixOS server on GCP GCE, using https://nixops.readthedocs.io/en/latest/?
1. create a simple bare minimal server config with a SSH container (as local VM & GCP GCE)

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
