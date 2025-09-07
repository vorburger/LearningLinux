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

## Ops

* https://clan.lol
* https://nixos.org/manual/nixos/stable/
* https://nixops.dev & https://github.com/nixops4/nixops4
* https://github.com/nix-community/srvos
* https://github.com/nix-community/disko
* https://github.com/NixOS/nixos-hardware
* https://github.com/zhaofengli/colmena
* https://nix-community.github.io/nixos-anywhere/
* https://nix-community.github.io/home-manager/

## Mac

* https://nix-darwin.org

## Patterns

* https://github.com/nix-systems/nix-systems, and https://github.com/numtide/flake-utils (which uses `nix-systems`)
* https://flake.parts
* https://github.com/mightyiam/dendritic

## Tools

* https://github.com/nix-community/comma for `, anything` is `nix run` with https://github.com/nix-community/nix-index

### Format, Pre-Commit, etc.

* https://github.com/NixOS/nixfmt
* https://github.com/cachix/git-hooks.nix

## Integration

* https://github.com/nix-community/nixago #cue
* https://github.com/jmgilman/nix-cue #cue

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

## Community

### Meetups & User Groups

* @zimbatm Geneva ?
* https://socal-nug.com

### Conferences

* https://nixcon.org #europe
* https://planetnix.com #america

## Consulting

* https://numtide.com
* https://www.tweag.io
* https://determinate.systems
* https://flox.dev
* https://nixcademy.com
* https://cyberus-technology.de ("NixOS LTS")
* https://helsinki-systems.de
* https://obsidian.systems

## Examples

* https://github.com/thefossguy/prathams-nixos
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
1. https://nixos-and-flakes.thiscute.world
1. https://code.tvl.fyi/about/nix/nix-1p/README.md is a great succinct intro to the Nix functional language
1. https://nixos.org/guides/nix-pills/
1. https://nixos.org/manual/nix/stable/#ssec-builtins documents the `builtins`
1. https://nixos.org/manual/nixpkgs/stable/#sec-functions-library for `pkgs.lib` (AKA `import <nixpkgs/lib>`)
