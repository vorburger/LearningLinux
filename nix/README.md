# [Nix / NixOS](https://nixos.org)

## Installation

[Install Nix](docs/install.md).

## Run

Run `hello` from Nix:

    nix run nixpkgs#hello

Traditionally `nix-channel --list` would show which _channel_ this came from; e.g., `nixpkgs https://nixos.org/channels/nixos-unstable` (or a fixed version) - but channels shouldn't be used any more nowadays anyway.

If that is empty, such as in a modern Nix installation like [Determinate](docs/determinate.md)'s, then its _flake registry_ maps `nixpkgs` via the `extra-nix-path = nixpkgs=flake:nixpkgs` in `/etc/nix/nix.conf`. You can therefore also run: `nix run flake:nixpkgs#hello`. `nix flake metadata nixpkgs` will show the _Resolved_ and _Locked_ URLs, e.g., `github:NixOS/nixpkgs/nixpkgs-unstable`; this comes from `nix registry list`. With `nix run flake:nixpkgs#hello -- --version` we can see that the version of `hello` on `nixpkgs-unstable` is e.g. `2.12.2`.

Running `nix run github:NixOS/nixpkgs/24.11#hello -- --version` gives us `2.12.1` ... from https://github.com/NixOS/nixpkgs/blob/24.11/pkgs/by-name/he/hello/package.nix.

## Flakes 101

TODO _When run from a directory containing a `flake.nix` (see below), then its `nixpkgs` fixes the version._

## Flakes 102

```nix
{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }: {

    packages.x86_64-linux.hello = nixpkgs.legacyPackages.x86_64-linux.hello;

    packages.x86_64-linux.default = self.packages.x86_64-linux.hello;

  };
}
```

    mkdir flake1 && cd flake1
    nix flake new .
    git add flake.nix
    nix run

This ran the _default output_ of our Flake.

Update (or remove) the default `description`, and replace `?ref=nixos-unstable` with e.g. `?ref=nixos-24.11`; now `nix run` again, it still works (of course) - but it's more _"stable"._

If there is only 1 `inputs` then you could simplify it to `inputs.nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-24.11";`.

`nix run` without arguments runs the `default` package. It's equivalent to `nix run .#` and `nix run .#default`. For now, remove the default package, and instead directly run `nix run .#hello`.

We can run e.g. `java`, see [flake1](flake1/flake.nix).

## Packages

[`nix search`](https://zero-to-nix.com/start/nix-search/) evaluates locally.

https://search.nixos.org/packages is simpler.

`nix flake show` is useful. Run either in a directory with a `flake.nix`, or as e.g. `nix flake show "git+https://git.sr.ht/~kerstin/sway-timetracker?ref=main"` or of course even `nix flake -show -all-systems --legacy "github:nixos/nixpkgs?ref=nixos-24.11"` - because `nixpkgs` itself is also really just a (huge) Flake!

https://flakehub.com/flakes is a sort of "Forge" (?) for many more other Flakes; e.g. `nix flake show "https://flakehub.com/f/0x5a4/nand2tetris-flake/1.0.0"`. It mirrors nixpks as https://flakehub.com/flake/NixOS/nixpkgs, so e.g. `nix run "https://flakehub.com/f/NixOS/nixpkgs/*#hello"` instead of `nix run nixpkgs#hello`.

PS: The `legacyPackages` naming [here](https://github.com/vorburger/LearningLinux/blob/7dae2a2dde319170c7f99555522e1a95021a3dea/nix/flake1/flake.nix) is [just due to this](https://github.com/NixOS/nixpkgs/blob/fcc8ff7cc271c9652623dae2a9fcd1ba49232b57/flake.nix#L47-L55) (that's why `--legacy` above; the `--all-systems` is unrelated and for showing all "platforms").

## [Shell](https://nixos.org/manual/nix/stable/#sec-nix-shell)

    nix-shell -p hello
    nix-shell --pure --packages hello

## Lessons

1. `nix-shell` (non-pure) doesn't really give the required isolation, because you may still use local packages - so don't use that.
1. `nix-shell --pure` doesn't really work in practice, because it reads $HOME dotfiles, but then misses packages on `$PATH` - don't use.
1. `nix develop` basically has the same problems - also don't use?!

## Profile

To "globally" install packages (like a traditional package manager would):

    $ nix profile install nixpkgs#hello
    $ ~/.nix-profile/bin/hello
    Hello, world!

You would normally [put `~/.nix-profile/bin/` on your PATH](https://github.com/vorburger/vorburger-dotfiles-bin-etc/commit/5b8b1b364154e50a3ec6ec592b4edb5a7277143e#diff-44b95e9c6b0542d36f6a0e72f1d0be03f81d7afa9bf7ac4c7451164f1fb54323R4).

**TODO** _How to replace "imperative" Profile management with a fully "declarative" one?__

## REPL 101

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

## Eval

    nix eval --raw --impure --expr 'builtins.currentSystem'

## Containers from [Nixery](https://nixery.dev)

    podman run --rm -ti nixery.dev/shell/git/htop bash

    podman run --rm -t nixery.dev/hello hello
    podman unshare
    podman image mount nixery.dev/hello
    ls -al $(podman image mount nixery.dev/hello)
    podman image umount nixery.dev/hello

## Files

* [`nix.conf`](https://nixos.org/manual/nix/stable/#sec-conf-file)
* `~/.nix-profile`
  * `bin/` is on `$PATH`
  * `etc/`, `lib/`, `share` are like `/etc`, `/lib`, `/share`
* `~/.nix-channels` _TODO, after [reading more about channels](https://nixos.org/manual/nix/stable/package-management/channels.html)_
* `~/.nix-defexpr` _TODO_

## man

It's pretty cool how (at least on Fedora) e.g. `man direnv` still works after `nix profile install nixpkgs#direnv` even though it's not a DNF system package.

## Resources

My [docs](docs/)!

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

## ToDo

[See `todo.md`](todo.md)
