{
  inputs.nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-25.05";

  outputs = { self, nixpkgs }:
    let
      forAllSystems = f: nixpkgs.lib.genAttrs [ "x86_64-linux" "aarch64-darwin" ]
        (system: f { pkgs = import nixpkgs { inherit system; }; });
    in {

      devShells = forAllSystems ({ pkgs }: {
        default = pkgs.mkShell {
          packages = with pkgs; [
            protobuf
            # FYI Fish v3.7.1 on 24.11 but 4.0.2 on 25.05:
            fish
          ];
          shellHook = ''
            echo "Welcome to the Nix-based development environment shell! It has all required tools."

            # NB: We CANNOT "exec fish" here, because this breaks `nix develop --command`.
            # TODO How to enter the user's preferred $SHELL in nix develop, instead of hard-code my fish preference?
            # exec fish
          '';
        };
      });


      packages = forAllSystems ({ pkgs }: {

        java = pkgs.writeShellApplication {
          name = "java";
          runtimeInputs = [ pkgs.jdk23 ];
          text = "java --version";
        };
      });
    };
}
