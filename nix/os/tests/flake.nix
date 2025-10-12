{
  inputs.nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  outputs =
    { self, nixpkgs }:
    {
      checks.x86_64-linux.default = nixpkgs.legacyPackages.x86_64-linux.testers.runNixOSTest ./demo.nix;
    };
}
