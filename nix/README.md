# [Nix(OS)](https://nixos.org)

## ToDo

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

## Installation

* https://flox.dev/docs/install-flox/ (by https://github.com/refroni ? See https://nixos.org/blog/announcements/2025/foundation-board-2025/)
* https://zero-to-nix.com/start/install/ == https://determinate.systems/ (by https://github.com/edolstra ?)
* https://nixos.org/download/ (TODO Is that SELinux problem now solved?!)

Enable Flakes with `echo "extra-experimental-features = nix-command flakes" >>~/.config/nix/nix.conf` (if you don't have it already); see https://github.com/vorburger/vorburger-dotfiles-bin-etc/commit/b853a1becf993d26c7ca7c4b62fb117b895be232.

### Older Notes

Nix's single user installation requires no root at all [except the `/nix` creation](https://nixos.org/guides/nix-pills/install-on-your-running-system.html#idm140737320758576):

    sudo mkdir -m 0755 /nix
    sudo chown $USER /nix
    mkdir -m 0755 /nix && chown vorburger /nix

    # logout and log back in
    alias n="nix "
    n --version

Nix (as in the `nix` CLI tool) [can be upgraded](https://nixos.org/manual/nix/stable/installation/upgrading.html)
with `nix-channel --update; nix-env -iA nixpkgs.nix nixpkgs.cacert`.

Nix [can GC](https://nixos.org/manual/nix/stable/#sec-garbage-collection)
(and [the pill](https://nixos.org/guides/nix-pills/garbage-collector.html)):
`du -h /nix; nix-collect-garbage -d; du -h /nix` (or `nix-store --gc`).

[Nix can be uninstalled](https://nixos.org/download.html#nix-uninstall)
with `rm -rf /nix ~/.nix-profile` (`~/.nix-profile/` is just a symlink into `/nix`),
note also [`nix.conf`](https://nixos.org/manual/nix/stable/#sec-conf-file) locations.

## Usage

### Run

Run `hello` from Nix:

    nix run nixpkgs#hello

When run from a directory containing a `flake.nix` (see below), then its `nixpkgs` fixes the version.
**TODO** Otherwise, what exactly determines which `nixpkgs` _"channel"_ (version) this uses?

FYI, just for fun: Nix from Nix, Given that we have `nix`:

    $ nix --version
    nix (Nix) 2.24.12

We can use it to run the latest `nix` from it:

    $ nix run nixpkgs#nix -- --version
    nix (Nix) 2.28.3

### Flakes

    nix flake new .
    nix run

This ran the _default output_ of our Flake.

Replace `?ref=nixos-unstable` e.g. with `?ref=nixos-24.11`; now `nix run` still works (of course) - but it's more _"stable"._

### Packages 101

    nix-env -q
    # nix-x.y.z

    nix-env -qaP
    time nix-env -vi hello
    time nix-env -iA nixpkgs.hello
    nix-env -q
    hello -t
    which hello
    nix-env -e hello
    hello

### Upgrading

    nix-channel --update nixpkgs
    nix-env -uA nixpkgs.hello
    nix-env -u --dry-run
    nix-env -u

### Generations

    nix-env --list-generations
    nix-env --switch-generation 13
    nix-env --rollback

### [Shell](https://nixos.org/manual/nix/stable/#sec-nix-shell)

    nix-shell -p hello
    nix-shell --pure --packages hello
    shell

### REPL 101

https://nixos.org/guides/nix-pills/basics-of-language.html:

    $ n repl
    nix-repl> :help
    nix-repl> 1+1
    2
    nix-repl> greet="world"
    nix-repl> "hello, ${greet}"
    "hello, world"

https://nixos.org/guides/nix-pills/functions-and-imports.html:

    nix-repl> double = x: x*2
    nix-repl> let double = x: x*2; in double 3
    nix-repl> double 3
    6

    nix-repl> builtins.trace "hey" true

    nix-repl> import ./first-test.nix { arg1 = "default"; }
    "same!"

    nix-repl> :l <nixpkgs>
    Added 15102 variables.
    nix-repl> lib.unique [ 1 2 3 1 ]
    [ 1 2 3 ]

https://nixos.org/guides/nix-pills/our-first-derivation.html then explains the real power.

### Eval

    nix eval --raw --impure --expr 'builtins.currentSystem'

### Containers from [Nixery](https://nixery.dev)

    podman run --rm -ti nixery.dev/shell/git/htop bash

    podman run --rm -t nixery.dev/hello hello
    podman unshare
    podman image mount nixery.dev/hello
    ls -al $(podman image mount nixery.dev/hello)
    podman image umount nixery.dev/hello

### Files

* [`nix.conf`](https://nixos.org/manual/nix/stable/#sec-conf-file)
* `~/.nix-profile`
  * `bin/` is on `$PATH`
  * `etc/`, `lib/`, `share` are like `/etc`, `/lib`, `/share`
* `~/.nix-channels` _TODO, after [reading more about channels](https://nixos.org/manual/nix/stable/package-management/channels.html)_
* `~/.nix-defexpr` _TODO_

## Resources

### References

* https://nixos.wiki

### News

* https://weekly.nixos.org
* https://twitter.com/nixos_org

### Learning

Recommended reading, in this order:

1. https://nix.dev
1. https://nixos-and-flakes.thiscute.world
1. https://zero-to-nix.com
1. https://nixery.dev/nix-1p.html is a great succinct intro to the Nix functional language
1. https://nixos.org/guides/nix-pills/
1. https://nixos.org/manual/nix/stable/#ssec-builtins documents the `builtins`
1. https://nixos.org/manual/nixpkgs/stable/#sec-functions-library for `pkgs.lib` (AKA `import <nixpkgs/lib>`)

## Troubleshooting

### `error: path '/nix/store/...-source/flake.nix' does not exist`

If the `flake.nix` is in the curent working directory (e.g. when running `nix run .#mvnw -- clean test` or `nix develop .`), but not in the `/nix/store/...-source/`, then it's probably a new one?

You just need to `git add flake.nix` to fix this! You don't have to actually commit it, just stage is fine (it will whine about _"warning: Git tree '/home/vorburger/git/github.com/jline/jline3' is dirty"_ which makes sense).
