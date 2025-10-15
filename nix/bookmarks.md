# Awesome Nix Bookmarks

**ToDo:** Contribute (some of?) these to https://github.com/nix-community/awesome-nix.

## Install

* https://determinate.systems/nix-installer/ #determinate #recommended
* https://nixos.org/download/ #not-on-fedora
* https://flox.dev #nope #dont
* https://github.com/juhp/nix-fedora

## Dev

* `nix develop` (with `devShells` in `flake.nix`)
* https://github.com/nix-community/nix-direnv
* https://garn.io #ts (with a `garn.ts`)
* https://github.com/numtide/devshell for `nix develop` (with a `devshell.toml`)
* https://devenv.sh #cachix #[tvix](https://devenv.sh/blog/2024/10/22/devenv-is-switching-its-nix-implementation-to-tvix/) #[flakes-compatible](https://devenv.sh/guides/using-with-flakes/) (with a `devenv.nix`, and `devenv.yaml`, for `devenv`)
* https://www.jetify.com/devbox
* https://flox.dev (with a `.flox/env/manifest.toml` for `flox`)

## Cache & CI

* https://nix-ci.com
* https://cache.nixos.org
* https://flakehub.com
* https://www.cachix.org
* https://garnix.io
* https://nixbuild.net
* https://hercules-ci.com
* https://github.com/NixOS/hydra

## Hardware

* Facter
  * https://nix-community.github.io/nixos-facter-modules/latest/getting-started/generate-report/
  * https://github.com/nix-community/nixos-facter
  * https://github.com/nix-community/nixos-facter-modules
* https://github.com/NixOS/nixos-hardware

## Ops

* https://clan.lol
* https://nixos.org/manual/nixos/stable/
* https://nixops.dev & https://github.com/nixops4/nixops4
* https://github.com/nix-community/srvos
* https://github.com/nix-community/disko
* https://github.com/zhaofengli/colmena
* https://nix-community.github.io/nixos-anywhere/
* https://nix-community.github.io/home-manager/
* https://std.divnix.com/

## Security

* https://github.com/nix-community/impermanence #ToDo
* https://git.afnix.fr/lanzaboote/lanzaboote #ToDo
* https://github.com/Mic92/sops-nix

## Mac

* https://nix-darwin.org

## Patterns

* https://flake.parts
* https://github.com/numtide/flake-utils
* https://github.com/numtide/blueprint
* https://github.com/nix-systems/nix-systems, and https://github.com/numtide/flake-utils (which uses `nix-systems`)
* https://github.com/mightyiam/dendritic
* https://codeberg.org/quasigod/unify
* https://yunfachi.github.io/denix/
* https://github.com/snowfallorg/lib
* https://github.com/gytis-ivaskevicius/flake-utils-plus

## Tools

* https://github.com/nix-community/comma for `, anything` is `nix run` with https://github.com/nix-community/nix-index

### Format, Pre-Commit, etc.

* https://github.com/NixOS/nixfmt
* https://github.com/cachix/git-hooks.nix

## Theming

* https://github.com/nix-community/stylix

## Integration

* https://github.com/nix-community/nixago #cue
* https://github.com/jmgilman/nix-cue #cue

## Distros

* https://snowflakeos.org

## Alternative

### Nix Language Implementation

* https://github.com/NixOS/nix AKA CppNix
* https://lix.systems #rust
* https://tvix.dev #rust @[flokli](https://flokli.de/) and @[tazjin](https://tazj.in/)
* https://snix.dev #rust forkOf:tvix

### Configuration Language

* [Nix Language](https://nix.dev/manual/nix/2.28/language/index.html)
* https://cuelang.org ##cue
* https://hofstadter.io #cue
* https://nickel-lang.org
* https://dhall-lang.org
* https://jsonnet.org
* [Starlark](https://github.com/bazelbuild/starlark)
* https://www.kcl-lang.io
* https://github.com/hashicorp/hcl
* https://pkl-lang.org
* https://github.com/jakehamilton/dotbox

## Community

### Chat

* https://matrix.to/#/#space:nixos.org supposedly, but https://github.com/NixOS/nixos-homepage/issues/1865

### Forums

* https://discourse.nixos.org

### Meetups & User Groups

* @zimbatm Geneva / Lausanne ?
* https://zurich.nix.ug
* https://socal-nug.com

### Conferences

* https://nixcon.org #europe
* https://planetnix.com #america

## Alternatives

* https://auxolotl.org

## Consulting

* https://nixos.org/community/commercial-support/
* https://numtide.com
* https://www.tweag.io
* https://determinate.systems
* https://flox.dev
* https://nixcademy.com
* https://cyberus-technology.de ("NixOS LTS")
* https://helsinki-systems.de
* https://obsidian.systems

## Examples

* https://vic.github.io/dendrix/Dendritic.html
  * https://github.com/vic/vix/
  * https://github.com/mightyiam/infra
  * https://github.com/gaetanlepage/nix-config
  * https://github.com/dliberalesso/nix-config/
  * https://github.com/drupol/infra (from [here](https://mathstodon.xyz/@Pol/115168596288038824))
  * https://github.com/henrysipp/nix-setup
  * https://github.com/Maka-77x/nixconf7
  * https://codeberg.org/quasigod/nixconfig
  * https://codeberg.org/vic/quasigod-nixconfig
* https://github.com/RGBCube/ncc
* https://github.com/thefossguy/prathams-nixos (offered to help on email)
* https://forkspace.net/leona/nixfiles
* https://github.com/mitchellh/nixos-config
* https://github.com/splitbrain/infra-nas-nixos
* https://github.com/Joker9944/nix-config
* https://github.com/pl-misuw/nixos_config

## References

* https://noogle.dev
* https://nixos.wiki

## News

* https://fulltimenix.com
* https://weekly.nixos.org
* https://twitter.com/nixos_org

## Learning

Recommended reading, in this order:

1. https://zero-to-nix.com
1. https://nix.dev
1. https://vtimofeenko.com/posts/practical-nix-flake-anatomy-a-guided-tour-of-flake.nix
1. https://serokell.io/blog/practical-nix-flakes
1. https://nixos-and-flakes.thiscute.world
1. https://code.tvl.fyi/about/nix/nix-1p/README.md is a great succinct intro to the Nix functional language
1. https://nixos.org/guides/nix-pills/
1. https://nixos.org/manual/nix/stable/#ssec-builtins documents the `builtins`
1. https://nixos.org/manual/nixpkgs/stable/#sec-functions-library for `pkgs.lib` (AKA `import <nixpkgs/lib>`)
