# Troubleshoot

### warning: ignoring the client-specified setting 'sandbox', because it is a restricted setting and you are not a trusted user

You need to add your username to the `trusted-users` list in `/etc/nix/nix.conf` (e.g., `trusted-users = root your-username-here`), and then restart the Nix daemon with `sudo systemctl restart nix-daemon.service`.

PS: Originally from http://docs.enola.dev/use#nix, but since https://github.com/enola-dev/enola/issues/1730 no longer required there.

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
