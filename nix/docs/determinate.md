# Determinate Nix

https://determinate.systems/ (by https://github.com/edolstra ?) as it handles SELinux on Fedora and "just works", see https://zero-to-nix.com/start/install/.

It's fairly up-to-date (on 2025-05-11 `nix --version` is `nix (Determinate Nix 3.4.2) 2.28.3)`).

It has a clean https://zero-to-nix.com/start/uninstall/ at `/nix/nix-installer uninstall`.

Its `nix` is at `/nix/var/nix/profiles/default/bin/nix` which is added to the `$PATH` by `/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh` that is sourced by `/etc/profile.d/nix.sh`. There is also a `/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish` for direct use by the Fish Shell without another parent shell.
