# Trivial Nix VM

    nix run

and we can login as `root` on the console (without password), or with SSH via:

    ../../../bin/ssh-2222

## ToDo

1. Merge this into https://github.com/vorburger/nixfiles
1. Separate Flake from NixOS *.nix, like e.g. in https://michael.stapelberg.ch/posts/2025-06-01-nixos-installation-declarative/
1. KbdInteractiveAuthentication https://github.com/NixOS/nixpkgs/blob/5da4a26309e796daa7ffca72df93dbe53b8164c7/nixos/modules/services/networking/ssh/sshd.nix#L528C15-L528C43
1. disko
1. non-root user
1. home-manager
1. modularize configuration; see e.g. https://gemini.google.com/app/ee5b8586e02ddc32 but also Dendritic thing
1. https://nix.dev/tutorials/module-system/a-basic-module/
1. https://nixos.org/manual/nixos/stable/#ch-system-state with https://github.com/nix-community/impermanence and https://wiki.nixos.org/wiki/Impermanence
1. [edgetpu](https://michael.stapelberg.ch/posts/2025-06-01-nixos-installation-declarative/#making-changes)?
1. https://clan.lol
1. https://nix-community.github.io/nixos-facter-modules/latest/getting-started/generate-report/ about https://github.com/nix-community/nixos-facter and https://github.com/nix-community/nixos-facter-modules
1. https://codeberg.org/vula/vula
