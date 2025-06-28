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
            protoc --version
            # TODO How to use users preferred $SHELL in nix develop, instead of hard-code my fish preference?
            exec fish
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
