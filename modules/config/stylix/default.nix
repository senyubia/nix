{
  system = { inputs, ... }: {
    imports = [
      inputs.stylix.nixosModules.stylix
      ./nord.nix
    ];

    stylix = {
      enable = true;

      fonts = {
        serif = {
          package = pkgs.nerd-fonts.ubuntu;
          name = "Ubuntu Nerd Font";
        };
        sansSerif = {
          package = pkgs.nerd-fonts.ubuntu-sans;
          name = "UbuntuSans Nerd Font";
        };
        monospace = {
          package = pkgs.nerd-fonts.ubuntu-mono;
          name = "UbuntuMono Nerd Font";
        };
        emoji = {
          package = pkgs.noto-fonts-color-emoji;
          name = "Noto Color Emoji";
        };

        sizes = {
          applications = 10;
          terminal = 10;
          desktop = 10;
          popups = 10;
        };
      };

      opacity = {
        applications = 1.0;
        terminal = 0.8;
        desktop = 0.8;
        popups = 1.0;
      };

      targets = {
        grub.enable = false;
      };
    };
  };

  home = {
    stylix.targets = {
      firefox.profileNames = [ "default" ];
    };
  };
}
