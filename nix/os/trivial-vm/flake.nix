{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs =
    { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      lib = nixpkgs.lib;
    in
    {
      nixosConfigurations.vm1 = lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          (
            { pkgs, ... }:
            {
              services.openssh.enable = true;
              # users.users.root.password = ""; # TESTING, only!
              users.users.root.openssh.authorizedKeys.keys = [
                "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC+qSqOeDos2pCI1Q0tm44FgghgvOaX5WuPAXKRIw1/bwahPXnvTwJbSNdnIbQyDWZCmvJaXr6wnDP8faQBZcIyBBjD4JOoVONfvTw2/RKPHBB9eb6h8q6Jl1STsCk/8+Qv5PXhSjCJQ2mJdaE56wKrrPL/bIyOInx1KQj0rygV96KFj67CeXpjpMqOxAxcJyjp6/cxAGJyL81lcjA2HFKhwjeHS71ipOstmG+n6cOjd2x5V5Qv7j1x2zKSnxCJOU7PHphm7UqPUlvCcrKLq+YZ2VWSjjHiu+GUIR7dp1HG73W5uSmhgAM2fQEhldT53Lc2tCYwyrMq/C1hAtq/S26BxmibR8jmAxIqJ4JB9Njv/r97/6amI8LxnzuRBnDhA6cW9JHUBrNoG41vTwopdAz9DjaklzeRAjStoQY9rE6Ck6GXzuqUuLaBryS1JETKpxWvbQrnFA/yS9qFl/oDlfjYT0dX4oeWK58tCgdDD42SF4fUP6zpQZzHx4iwKGukMV3e87DW5tKTs2yCQzeBgw664mlG0WbYdj1TZ0n7MRXAr9aKpPSiW0H94A+0cZS/VJdVAxrRgbPv3Uk9W7E/tq4aMySRTm6ZlU0HTKlkg5adnQl5yM8ZxyOdYybnsq9ZyyUlsc9cmEfyOvIOP9cvi2pN5cpmDNG+pZ+mEHJ5aU95WQ=="
              ];
              system.stateVersion = "25.11";
            }
          )
        ];
      };

      # x86_64-linux only (for now), so intentionally omitted
      packages.run-vm1 = pkgs.writeShellScriptBin "run-vm1" ''
        rm -f *.qcow2
        QEMU_NET_OPTS="hostfwd=tcp::2222-:22" exec "${self.nixosConfigurations.vm1.config.system.build.vm}/bin/run-nixos-vm" "$@"
      '';
      packages.x86_64-linux.default = self.packages.run-vm1;

      formatter.x86_64-linux = pkgs.nixfmt-tree;
    };
}
