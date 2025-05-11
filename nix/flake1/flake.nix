{
  inputs.nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-24.11";

  outputs = { self, nixpkgs }: {

    # TODO Why "legacyPackages"?
    # TODO How to avoid repeating "nixpkgs.legacyPackages.x86_64-linux" and just use pkgs?

    packages.x86_64-linux.hello = nixpkgs.legacyPackages.x86_64-linux.hello;

    packages.x86_64-linux.java =
      nixpkgs.legacyPackages.x86_64-linux.writeShellApplication {
        name = "java";
        runtimeInputs = [ nixpkgs.legacyPackages.x86_64-linux.jdk23 ];
        text = ''
          # exec ./mvnw "$@"
          java --version
          # java "$@"
        '';
      };
  };
}
