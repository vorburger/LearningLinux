# https://nixcademy.com/posts/nixos-integration-tests-part-2/
{
  name = "Two machines ping each other";

  nodes = {
    # These configs do not add anything to the default system setup
    machine1 = { pkgs, ... }: { };
    machine2 = { pkgs, ... }: { };
  };

  testScript = ''
    machine1.systemctl("start network-online.target")
    machine2.systemctl("start network-online.target")
    machine1.wait_for_unit("network-online.target")
    machine2.wait_for_unit("network-online.target")

    machine1.succeed("ping -c 1 machine2")
    machine2.succeed("ping -c 1 machine1")
  '';
}
