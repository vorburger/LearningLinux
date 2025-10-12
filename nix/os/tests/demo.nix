# https://nixcademy.com/posts/nixos-integration-tests-part-2/
{
  name = "Two machines ping each other";

  nodes = {
    # These configs do not add anything to the default system setup
    machine1 = { pkgs, ... }: { };
    machine2 = { pkgs, ... }: { };
  };

  testScript = ''
    start_all()
    for m in [machine1, machine2]:
      m.systemctl("start network-online.target")
      m.wait_for_unit("network-online.target")

    machine1.succeed("ping -c 1 machine2")
    machine2.succeed("ping -c 1 machine1")
  '';
}
