{...} : {

  disko.devices = {
    disk = {
      my-disk = {
        device = "/dev/sda";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              type = "EF00";
              size = "500M";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };
            root = {
              size = "100%";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/";
              };
            };
          };
        };
      };
    };
  };
  
  boot.loader = {
    # No need to touch machine's NVRAM, we just put bootloader where it is
    # expected by default: /part(type=EF00)/EFI/BOOT/BOOTX64.EFI
    # This works very well when swapping boot disks.
    efi.canTouchEfiVariables = false;
    efi.efiSysMountPoint = "/boot";
    systemd-boot = {
      enable = true;
      memtest86.enable = true;
      configurationLimit = 5;
    };
  };

  users.users.vorburger.initialPassword = "x";
  users.users.vorburger.group = "wheel";
  users.users.vorburger.isNormalUser = true;

  system.stateVersion = "25.05";
}
