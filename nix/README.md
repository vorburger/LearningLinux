# [Nix / NixOS](https://nixos.org)

## Installation

Use [Determinate Nix](#determinate-nix) https://zero-to-nix.com/start/install/, instead of:

* https://nixos.org/download/ does still [not support SELinux on Fedora](https://github.com/NixOS/nix/issues/2374)
* [`sudo dnf copr enable petersen/nix && sudo dnf install nix && sudo systemctl enable --now nix-daemon && sudo -K`](https://github.com/juhp/nix-fedora); but:
  * [Problem with the SSL CA cert](#error-unable-to-download-httpsapigithubcomreposnixosnixpkgscommitsnixos-unstable-problem-with-the-ssl-ca-cert-path-access-rights-77)
  * https://github.com/juhp/nix-fedora/issues/3 Fedora 42 problem
  * https://github.com/juhp/nix-fedora/issues/5 Socket directory needs to be manually created
  * As of 2025-05-11, still has 2.19.4; with 2.28.3 only on the rawhide repo
  * Uninstall with: `sudo systemctl disable --now nix-daemon && sudo dnf remove nix && sudo rm -rf /nix && sudo dnf copr remove petersen/nix && sudo groupdel nixbld`
* [NOT Flox](#flox)

Enable Flakes with `echo "extra-experimental-features = nix-command flakes" >>~/.config/nix/nix.conf` (if you don't have it already); see https://github.com/vorburger/vorburger-dotfiles-bin-etc/commit/b853a1becf993d26c7ca7c4b62fb117b895be232.

PS: [Gemini 🔮 Tips](https://gemini.google.com/app/69ffbf8c55cb1264) re. SELinux on Fedora.

## Determinate Nix

https://determinate.systems/ (by https://github.com/edolstra ?) as handles SELinux on Fedora and "just works".

It's fairly up-to-date (on 2025-05-11 `nix --version` is `nix (Determinate Nix 3.4.2) 2.28.3)`).

It has a clean https://zero-to-nix.com/start/uninstall/ at `/nix/nix-installer uninstall`.

Its `nix` is at `/nix/var/nix/profiles/default/bin/nix` which is added to the `$PATH` by `/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh` that is sourced by `/etc/profile.d/nix.sh`. There is also a `/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish` for direct use by the Fish Shell without another parent shell.

## Maintenance

Nix (as in the `nix` CLI tool) [can be upgraded](https://nixos.org/manual/nix/stable/installation/upgrading.html)
with `nix-channel --update; nix-env -iA nixpkgs.nix nixpkgs.cacert`.

Nix [can GC](https://nixos.org/manual/nix/stable/#sec-garbage-collection)
(and [the pill](https://nixos.org/guides/nix-pills/garbage-collector.html)):
`du -h /nix; read -p "Note current /nix disk usage..."; nix-collect-garbage -d; du -h /nix` (not directly `nix-store --gc`).

[Nix can be uninstalled](https://nix.dev/manual/nix/2.28/installation/uninstall)
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

## [Shell](https://nixos.org/manual/nix/stable/#sec-nix-shell)

    nix-shell -p hello
    nix-shell --pure --packages hello

## Lessons

1. `nix-shell` (non-pure) doesn't really give the required isolation, because you may still use local packages - so don't use that.
1. `nix-shell --pure` doesn't really work in practice, because it reads $HOME dotfiles, but then misses packages on `$PATH` - don't use.
1. `nix develop` basically has the same problems - also don't use?!

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

## Troubleshooting

### error: cannot connect to socket at '/nix/var/nix/daemon-socket/socket': No such file or directory

    sudo systemctl enable --now nix-daemon

### New `flake.nix` causing `error: path '/nix/store/...-source/flake.nix' does not exist`

If the `flake.nix` is in the current working directory (e.g. when running `nix run .#mvnw -- clean test` or `nix develop .`), but not in the `/nix/store/...-source/`, then it's probably a new one?

You just need to `git add flake.nix` to fix this! You don't have to actually commit it, just stage is fine (it will whine about _"warning: Git tree '/home/vorburger/git/github.com/jline/jline3' is dirty"_ which makes sense).

### `error: path '/nix/store/...-source' does not exist`

The following error, similar to above, but on `import <nixpkgs>` in a `shell.nix` on expected to be well known working external package:

```sh
$ nix-shell
error:
       … while calling the 'import' builtin
         at /home/vorburger/git/github.com/nix-community/vscode-nix-ide/shell.nix:1:10:
            1| { pkgs ? import <nixpkgs> { } }:
             |          ^
            2| pkgs.mkShell {

       error: path '/nix/store/4m21g6b3bq78vn5skaxjmqwg7fnir87j-source' does not exist
```

This was caused and fixed by [uninstalling Flox](#flox) and instead [installing another Nix distribution](#installation).

```sh
$ sh
which nix
/usr/bin/nix

$ rpm -qf (which nix)
flox-1.4.1-1.x86_64
```

### ConditionPathIsReadWrite=/nix/var/nix/daemon-socket was not met

https://github.com/juhp/nix-fedora/issues/5:

```sh
sudo mkdir -p /nix/var/nix/daemon-socket
sudo chown root:nixbld /nix/var/nix/daemon-socket
sudo chmod 755 /nix/var/nix/daemon-socket
```

### error: filesystem error: directory iterator cannot open directory: No such file or directory `[/nix/var/nix/profiles/per-user/vorburger]`

    $ nix profile install nixpkgs#hello
    error: filesystem error: directory iterator cannot open directory: No such file or directory [/nix/var/nix/profiles/per-user/vorburger]

    $ ll ~/.nix-profile
    lrwxrwxrwx. vorburger vorburger 48 B 2025-03-28 19:04  /home/vorburger/.nix-profile ⇒ /nix/var/nix/profiles/per-user/vorburger/profile

    $ ll /nix/var/nix/profiles/per-user/
    drwxr-xr-x. root root 46 B 2025-05-01 10:51  root

    $ ll /nix/var/nix/profiles/per-user/vorburger/
    lsd: /nix/var/nix/profiles/per-user/vorburger/: No such file or directory (os error 2).

    $ sudo mkdir /nix/var/nix/profiles/per-user/$USER/
    $ sudo chown vorburger:vorburger /nix/var/nix/profiles/per-user/$USER/
    $ sudo -K
    $ nix profile install nixpkgs#hello
    $ ll /nix/var/nix/profiles/per-user/$USER/profile/bin/
    .r-xr-xr-x. root root 62 KB 1970-01-01 01:00  hello

### error: unable to download 'https://api.github.com/repos/NixOS/nixpkgs/commits/nixos-unstable': Problem with the SSL CA cert (path? access rights?) (77)

I originally assumed that this might be somehow related to and caused and fixed by uninstalling `petersen/nix` and instead [installing Determinate's Nix distribution](#installation); however that showed the same problem, but now with a bit more details (likely due to a more recent `nix` version): error: unable to download 'https://api.github.com/repos/NixOS/nixpkgs/commits/nixos-unstable': Problem with the SSL CA cert (path? access rights?) (77) error setting certificate file: /nix/store/9zxb5ln0awpc13s0gv1vz7f28wyvn2x1-nss-cacert-3.108/etc/ssl/certs/ca-bundle.crt

And indeed `/nix/store/9zxb5ln0awpc13s0gv1vz7f28wyvn2x1-nss-cacert-3.108/etc/ssl/certs/ca-bundle.crt` does not exist.

`find /nix/store/ -name "*cacert*"` finds `/nix/store/y2zh06pccwcvz43xwgd8mr8pbqflkqww-nss-cacert-3.107` - one version previous.

It of course has nothing to do with GitHub's SSL; e.g. with `echo "Hello Nix" | nix run "https://flakehub.com/f/NixOS/nixpkgs/*#ponysay"` from https://zero-to-nix.com/start/nix-run/ the exact same problem happens.

`echo $NIX_SSL_CERT_FILE` shows that it's that environment variable which is set to wrong version. `nix show-config` shows that `ssl-cert-file` is wrong.

`NIX_SSL_CERT_FILE` is set in `/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh` which is sourced by `/etc/profile.d/nix.sh`.

`NIX_SSL_CERT_FILE=/nix/store/y2zh06pccwcvz43xwgd8mr8pbqflkqww-nss-cacert-3.107/etc/ssl/certs/ca-bundle.crt nix run nixpkgs#hello` works around it, but is not permanent.

That `/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh` script does not re-run if `__ETC_PROFILE_NIX_SOURCED` is already set. And even if it runs, if `NIX_SSL_CERT_FILE` is already set then that takes precedence. So it's pretty sticky and tough to get rid of a previous old value from a previous installation. A session logout and re-login might not help; but this could be specific to TMUX and/or Fish servers (?). However a full machine reboot does fix this problem!

## Flox

https://flox.dev/docs/install-flox/ caused [strange problems](#error-path-nixstore-source-does-not-exist).

It's by https://github.com/refroni ? See https://nixos.org/blog/announcements/2025/foundation-board-2025/

I have [some personal Notes about Flox](https://github.com/vorburger/Notes/blob/master/Reference/flox.md).

How to uninstall Flox:

```sh
sudo dnf remove flox
sudo rm /etc/nix/nix.conf
```

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

## ToDo

[See `todo.md`](todo.md)
