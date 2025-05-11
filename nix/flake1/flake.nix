{
  inputs.nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-24.11";

  outputs = { self, nixpkgs }: {

    packages.x86_64-linux.hello = nixpkgs.legacyPackages.x86_64-linux.hello;

    packages.x86_64-linux.mvnw = nixpkgs.x86_64-linux.writeShellApplication {
      name = "mvnw";
      runtimeInputs = [ nixpkgs.jdk24 ];
      text = ''
        exec ./mvnw "$@"
      '';
    };
  };
}
