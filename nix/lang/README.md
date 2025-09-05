# Nix Lang

## Sum

    $ nix eval --file sum.nix
    { three = 3; }

    $ nix eval --file sum.nix three
    3

    $ nix repl
    nix-repl> :load sum.nix
    nix-repl> three
    3
