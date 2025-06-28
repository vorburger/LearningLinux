# Nix CLI

FYI, just for fun: Nix from Nix, Given that we have `nix`:

    $ nix --version
    nix (Nix) 2.24.12

We can use it to run the latest `nix` from it:

    $ nix run nixpkgs#nix -- --version
    nix (Nix) 2.28.3
