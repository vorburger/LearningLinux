{
  description = "Nix Flake for Java development with JDK, Protobuf, and a simple Hello World example";

  inputs.nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-25.05";

  outputs =
    { self, nixpkgs }:
    let
      jdkVersion = "jdk23";

      forAllSystems =
        f:
        nixpkgs.lib.genAttrs [ "x86_64-linux" "aarch64-darwin" ] (
          system:
          let
            pkgs = import nixpkgs { inherit system; };
            jdk = pkgs.${jdkVersion};
          in
          f {
            pkgs = pkgs;
            jdk = jdk;
          }
        );
    in
    {

      devShells = forAllSystems (
        { pkgs, jdk }:
        {
          default = pkgs.mkShell {
            packages = with pkgs; [
              jdk
              protobuf
            ];
            shellHook = ''
              echo "Welcome to the Nix-based development environment shell! It has all required tools."
            '';
          };
        }
      );

      packages = forAllSystems (
        { pkgs, jdk }:
        {

          hello = pkgs.stdenv.mkDerivation {
            name = "hello";
            src = self;
            # TODO Use JRE instead of JDK for runtime vs build
            runtimeInputs = [ jdk ];
            buildInputs = [ jdk ];
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
              exec ${jdk}/bin/java -classpath $out/share/java/hello Hello "$@"
              EOF

              chmod +x $out/bin/hello
              echo "Installation complete. The application can be run via '$out/bin/hello'."
            '';
          };
        }
      );
    };
}
