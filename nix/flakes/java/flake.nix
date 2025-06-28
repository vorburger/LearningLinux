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
          ];
          shellHook = ''
            echo "Welcome to the Nix-based development environment shell! It has all required tools."
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
