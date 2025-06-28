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
            jdk23
            protobuf
          ];
          shellHook = ''
            echo "Welcome to the Nix-based development environment shell! It has all required tools."
          '';
        };
      });


      packages = forAllSystems ({ pkgs }: {

        # TODO Use real `stdenv.mkDerivation` instead of this... which is "impure" anyway!
        hello = pkgs.writeShellApplication {
          name = "hello";
          # TODO Avoid repeating the JDK (with version) here, but how?
          runtimeInputs = [ pkgs.jdk23 ];
          # TODO /nix/store/yrxi27xf7rv5lxj32mfr5favk4530nj1-hello/bin/hello: line 8: script.sh: command not found
          text = "script.sh";
        };
      });
    };
}
