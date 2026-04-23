{
  system = { inputs, ... }: {
    imports = [
      inputs.stylix.nixosModules.stylix
      ./theme.nix
    ];

    stylix.targets = {
      grub.enable = false;
    };
  };

  home.stylix.targets = {
    firefox.profileNames = [ "default" ];
  };
}
