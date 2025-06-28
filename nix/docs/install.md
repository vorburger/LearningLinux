# Installation

See [Nix Installers Bookmarks](../bookmarks.md#install).

We currently recommend using [Determinate Nix](determinate.md), instead of:

* https://nixos.org/download/ does still [not support SELinux on Fedora](https://github.com/NixOS/nix/issues/2374)
* [`sudo dnf copr enable petersen/nix && sudo dnf install nix && sudo systemctl enable --now nix-daemon && sudo -K`](https://github.com/juhp/nix-fedora); but:
  * [Problem with the SSL CA cert](troubleshoot.md#error-unable-to-download-httpsapigithubcomreposnixosnixpkgscommitsnixos-unstable-problem-with-the-ssl-ca-cert-path-access-rights-77)
  * https://github.com/juhp/nix-fedora/issues/3 Fedora 42 problem
  * https://github.com/juhp/nix-fedora/issues/5 Socket directory needs to be manually created
  * As of 2025-05-11, still has 2.19.4; with 2.28.3 only on the rawhide repo
  * Uninstall with: `sudo systemctl disable --now nix-daemon && sudo dnf remove nix && sudo rm -rf /nix && sudo dnf copr remove petersen/nix && sudo groupdel nixbld`
* [NOT Flox](flox.md)

Enable Flakes with `echo "extra-experimental-features = nix-command flakes" >>~/.config/nix/nix.conf` (if you don't have it already); see https://github.com/vorburger/vorburger-dotfiles-bin-etc/commit/b853a1becf993d26c7ca7c4b62fb117b895be232.

PS: [Gemini 🔮 Tips](https://gemini.google.com/app/69ffbf8c55cb1264) re. SELinux on Fedora.

## Upgrade

Nix (as in the `nix` CLI tool) [can be upgraded](https://nixos.org/manual/nix/stable/installation/upgrading.html)
with `nix-channel --update; nix-env -iA nixpkgs.nix nixpkgs.cacert`.

## Garbage Collect

Nix [can GC](https://nixos.org/manual/nix/stable/#sec-garbage-collection)
(and [the pill](https://nixos.org/guides/nix-pills/garbage-collector.html)):
`du -h /nix; read -p "Note current /nix disk usage..."; nix-collect-garbage -d; du -h /nix` (not directly `nix-store --gc`).

## Uninstall

Depends on the [installer](install) used:

[Determinate](determinate.md) comes with an uninstaller.

Otherwise, [Nix can be uninstalled](https://nix.dev/manual/nix/2.28/installation/uninstall)
with `rm -rf /nix ~/.nix-profile` (`~/.nix-profile/` is just a symlink into `/nix`),
note also [`nix.conf`](https://nixos.org/manual/nix/stable/#sec-conf-file) locations.
