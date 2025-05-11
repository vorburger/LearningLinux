# [Nix / NixOS](https://nixos.org)

## Installation

* https://flox.dev/docs/install-flox/ (by https://github.com/refroni ? See https://nixos.org/blog/announcements/2025/foundation-board-2025/)
* https://zero-to-nix.com/start/install/ == https://determinate.systems/ (by https://github.com/edolstra ?)
* https://nixos.org/download/ (TODO Is that SELinux problem now solved?!)

Enable Flakes with `echo "extra-experimental-features = nix-command flakes" >>~/.config/nix/nix.conf` (if you don't have it already); see https://github.com/vorburger/vorburger-dotfiles-bin-etc/commit/b853a1becf993d26c7ca7c4b62fb117b895be232.

## Maintenance

Nix (as in the `nix` CLI tool) [can be upgraded](https://nixos.org/manual/nix/stable/installation/upgrading.html)
with `nix-channel --update; nix-env -iA nixpkgs.nix nixpkgs.cacert`.

Nix [can GC](https://nixos.org/manual/nix/stable/#sec-garbage-collection)
(and [the pill](https://nixos.org/guides/nix-pills/garbage-collector.html)):
`du -h /nix; read -p "Note current /nix disk usage..."; nix-collect-garbage -d; du -h /nix` (not directly `nix-store --gc`).

[Nix can be uninstalled](https://nixos.org/download.html#nix-uninstall)
with `rm -rf /nix ~/.nix-profile` (`~/.nix-profile/` is just a symlink into `/nix`),
note also [`nix.conf`](https://nixos.org/manual/nix/stable/#sec-conf-file) locations.

## VSC

Install [Nix IDE](https://marketplace.visualstudio.com/items?itemName=jnoortheen.nix-ide) (`jnoortheen.nix-ide`), which is actively maintained at https://github.com/nix-community/vscode-nix-ide. (The `bbenoist.nix` https://github.com/bbenoist/vscode-nix, and others, are less popular and not maintained anymore.)

It needs `nixfmt`to be on the `PATH`; we can [install](https://github.com/vorburger/vorburger-dotfiles-bin-etc/blob/5b8b1b364154e50a3ec6ec592b4edb5a7277143e/nix-install.sh#L6) it "globally" into our [user profile](#profile).

## Run

Run `hello` from Nix:

    nix run nixpkgs#hello

When run from a directory containing a `flake.nix` (see below), then its `nixpkgs` fixes the version.
**TODO** _Otherwise, what exactly determines which `nixpkgs` _"channel"_ (version) this uses?_

FYI, just for fun: Nix from Nix, Given that we have `nix`:

    $ nix --version
    nix (Nix) 2.24.12

We can use it to run the latest `nix` from it:

    $ nix run nixpkgs#nix -- --version
    nix (Nix) 2.28.3

## Profile

To "globally" install packages (like a traditional package manager would):

    $ nix profile install nixpkgs#hello
    $ ~/.nix-profile/bin/hello
    Hello, world!

You would normally [put `~/.nix-profile/bin/` on your PATH](https://github.com/vorburger/vorburger-dotfiles-bin-etc/commit/5b8b1b364154e50a3ec6ec592b4edb5a7277143e#diff-44b95e9c6b0542d36f6a0e72f1d0be03f81d7afa9bf7ac4c7451164f1fb54323R4).

**TODO** _How to replace "imperative" Profile management with a fully "declarative" one?__

## Flakes 101

```html

<html>
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

**TODO** _Multiplatform support?_

## Packages 101

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

## Upgrading

    nix-channel --update nixpkgs
    nix-env -uA nixpkgs.hello
    nix-env -u --dry-run
    nix-env -u

## Generations

    nix-env --list-generations
    nix-env --switch-generation 13
    nix-env --rollback

## [Shell](https://nixos.org/manual/nix/stable/#sec-nix-shell)

    nix-shell -p hello
    nix-shell --pure --packages hello
    shell

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

### error: filesystem error: directory iterator cannot open directory: No such file or directory [/nix/var/nix/profiles/per-user/vorburger]

    $ nix profile install nixpkgs#hello
    error: filesystem error: directory iterator cannot open directory: No such file or directory [/nix/var/nix/profiles/per-user/vorburger]

    $ ll ~/.nix-profile
    lrwxrwxrwx. vorburger vorburger 48 B 2025-03-28 19:04  /home/vorburger/.nix-profile ⇒ /nix/var/nix/profiles/per-user/vorburger/profile

    $ ll /nix/var/nix/profiles/per-user/
    drwxr-xr-x. root root 46 B 2025-05-01 10:51  root

    $ ll /nix/var/nix/profiles/per-user/vorburger/
    lsd: /nix/var/nix/profiles/per-user/vorburger/: No such file or directory (os error 2).

    $ sudo mkdir /nix/var/nix/profiles/per-user/vorburger/
    $ sudo chown vorburger:vorburger /nix/var/nix/profiles/per-user/vorburger/
    $ nix profile install nixpkgs#hello
    $ ll /nix/var/nix/profiles/per-user/vorburger/profile/bin/
    .r-xr-xr-x. root root 62 KB 1970-01-01 01:00  hello

## ToDo

[See `todo.md`](todo.md)
