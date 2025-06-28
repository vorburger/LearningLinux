{
  description = "Nix Flake for Java development with JDK, Protobuf, and a simple Hello World example";

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

        hello = pkgs.stdenv.mkDerivation {
          name = "hello";
          src = self;
          # TODO Avoid repeating the JDK (with version) here, but how?
          # TODO Use JRE instead of JDK for runtime vs build
          runtimeInputs = [ pkgs.jdk23 ];
          buildInputs = [ pkgs.jdk23 ];
          buildPhase = ''
            javac Hello.java

            mkdir -p $out/src
            cp -r ${self}/*.java $out/src/
            javac -d $out/bin $out/src/Hello.java
          '';
          installPhase = ''
            mkdir -p $out/share/java/hello
            cp Hello.class $out/share/java/hello/
            mkdir -p $out/bin

            cat > $out/bin/hello << EOF
            #!${pkgs.bash}/bin/bash
            exec ${pkgs.jdk23}/bin/java -classpath $out/share/java/hello Hello "$@"
            EOF

            chmod +x $out/bin/hello
            echo "Installation complete. The application can be run via '$out/bin/hello'."
          '';
        };
      });
    };
}
