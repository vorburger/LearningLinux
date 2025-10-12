{
  inputs.nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  outputs =
    { self, nixpkgs }:
    {
      packages.x86_64-linux.default = nixpkgs.legacyPackages.x86_64-linux.testers.runNixOSTest ./demo.nix;

      checks.x86_64-linux.default = self.packages.x86_64-linux.default;
    };
}
