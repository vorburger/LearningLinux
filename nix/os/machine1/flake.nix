{
  inputs = {
    # nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-25.05";
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
    # vorburger.url = "github:vorburger/vorburger-dotfiles-bin-etc";
  };

  outputs = { self, nixpkgs, ... }@inputs: {

    nixosConfigurations.machine1 = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        inputs.disko.nixosModules.disko
        ./machine1.nix
        # ({ ... }: {})
      ];
    };
    
    #packages.x86_64-linux.hello = nixpkgs.legacyPackages.x86_64-linux.hello;
    #packages.x86_64-linux.default = self.packages.x86_64-linux.hello;
  };
}
