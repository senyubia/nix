{ pkgs, inputs, ... }: {
  imports = [
    inputs.stylix.homeModules.stylix
    ./theme.nix
  ];

  stylix.targets = {
    firefox.profileNames = [ "default" ];

    qt.enable = true;
  };
}
