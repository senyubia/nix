{ pkgs, assets, ... }: {
  stylix = {
    enable = true;

    image = "${assets}/wp.png";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/nord.yaml";

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 16;
    };

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

    icons = {
      enable = true;
      package = pkgs.papirus-icon-theme.override { color = "yaru"; };
      dark = "Papirus-Dark";
    };

    opacity = {
      applications = 1.0;
      terminal = 0.8;
      desktop = 0.8;
      popups = 0.8;
    };

    polarity = "dark";
  };
}
