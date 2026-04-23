{
  system = { pkgs, ... }: {
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;

      extraPackages = with pkgs; [
        kdePackages.qt5compat
      ];

      theme = "where_is_my_sddm_theme";
    };

    systemd.services."autovt@tty2".enable = false;
    systemd.services."autovt@tty3".enable = false;
    systemd.services."autovt@tty4".enable = false;
    systemd.services."autovt@tty5".enable = false;
    systemd.services."autovt@tty6".enable = false;
    systemd.services."autovt@tty7".enable = false;

    systemd.services.switch-tty-postwake = {
      description = "Switch to tty2 after wake";

      after = [ "suspend.target" "hibernate.target" "hybrid-sleep.target" ];
      wantedBy = [ "suspend.target" "hibernate.target" "hybrid-sleep.target" ];

      serviceConfig = {
        Type = "oneshot";

        ExecStart = "${pkgs.kbd}/bin/chvt 2";
      };
    };

    environment.systemPackages = with pkgs; [
      (where-is-my-sddm-theme.override {
        themeConfig.General = {
          passwordFontSize = "18";
          passwordCursorColor = "#ffffff";
        };
      })
    ];
  };
}
