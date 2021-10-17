# [Nix(OS)](https://nixos.org)

## ToDo

1. READ! Manual, Pills, ...
1. sandbox? Explore.. try accessing file, and network via `curl`
1. `nix run` missing `./default.nix` what's that?
1. use https://nixos.org/manual/nix/stable/#sec-nix-shell in my scripts
1. write a `shell.nix` for `man nix-shell` (in https://github.com/vorburger/vorburger-dotfiles-bin-etc/)
1. containers build?
1. create a NixOS VM
1. install NixOS baremetal server, fully automated
1. install NixOS server on GCP GCE
1. create a simple bare minimal server config with a SSH container (as local VM & GCP GCE)
1. https://nixbuild.net/#pricing
1. https://github.com/nixos/hydra
1. Local [Nixery](https://nixery.dev)


## Installation

Nix's single user installation requires no root at all except the `/nix` creation:

    sudo mkdir -m 0755 /nix
    sudo chown $USER /nix
    mkdir -m 0755 /nix && chown vorburger /nix

    # logout and log back in
    alias n="nix "
    n --version

[Nix can be upgraded](https://nixos.org/manual/nix/stable/#ch-upgrading-nix)
with `nix-channel --update; nix-env -iA nixpkgs.nix` (although this downgraded 2.3.16 to 2.3.15 for me at first).

[Nix can GC](https://nixos.org/manual/nix/stable/#sec-garbage-collection)
(and [the pill](https://nixos.org/guides/nix-pills/garbage-collector.html)):
`du -h /nix; nix-collect-garbage -d; du -h /nix` (or `nix-store --gc`).

[Nix can be uninstalled](https://nixos.org/download.html#nix-uninstall)
with `rm -rf /nix ~/.nix-profile` (`~/.nix-profile/` is just a symlink into `/nix`),
note also [`nix.conf`](https://nixos.org/manual/nix/stable/#sec-conf-file) locations.


## Usage

### Packages 101

    nix-env -q
    # nix-x.y.z

    nix-env -qa
    nix-env -vi hello
    nix-env -q
    hello -t
    which hello
    nix-env -e hello
    hello

### Upgrading

    nix-env -u --dry-run
    nix-env -u

### [Shell](https://nixos.org/manual/nix/stable/#sec-nix-shell)

    nix-shell -p hello
    shell

### Files

* [`nix.conf`](https://nixos.org/manual/nix/stable/#sec-conf-file)
* `~/.nix-profile`
  * `bin/` is on `$PATH`
  * `etc/`, `lib/`, `share` are like `/etc`, `/lib`, `/share`
* `~/.nix-channels` _TODO, after reading about channels_
* `~/.nix-defexpr` _TODO_

## Resources

### News

* https://weekly.nixos.org
* https://twitter.com/nixos_org

### Learning

* https://nixos.org/guides/nix-pills/
