{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }: {

    packages.x86_64-linux.hello = nixpkgs.legacyPackages.x86_64-linux.hello;

    packages.x86_64-linux.default = self.packages.x86_64-linux.hello;

    # TODO mkShellNoCC ?
    packages.x86_64-linux.hoi = nixpkgs.legacyPackages.x86_64-linux.writeShellApplication {
      name = "hoi";
      # runtimeInputs = [ ... ];
      text = "echo 'Hoi zämä!'";
    };
  };
}
