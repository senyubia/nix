{ assets, ... }: {
  boot.loader = {
    grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;

      splashImage = "${assets}/wp.png";

      extraEntries = ''
        menuentry "UEFI Firmware Settings" --class efi {
          fwsetup
        }
      '';
    };

    efi.canTouchEfiVariables = true;
  };
}
