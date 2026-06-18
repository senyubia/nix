{ pkgs, assets, ... }: {
  stylix = {
    image = "${assets}/wp.png";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/nord.yaml";

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 16;
    };

    icons = {
      enable = true;
      package = pkgs.papirus-icon-theme.override { color = "yaru"; };
      dark = "Papirus-Dark";
    };

    polarity = "dark";
  };
}
