{ host, user, assets, ... }: {
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

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

  networking.hostName = "${host.name}";

  users.users.${user.name} = {
    isNormalUser = true;
    description = "${user.fullName}";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  system.stateVersion = "${host.state}";
}
