{ config, pkgs, inputs, ... }: {
  programs = {
    hyprland.enable = true;
    xwayland.enable = true;
  };

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

  services.logind.settings.Login = {
    HandleLidSwitch = "ignore";
#    HandleLidSwitchExternalPower = "ignore";
#    HandleLidSwitchDocker = "ignore";
  };

  services.acpid = {
    enable = true;

    lidEventCommands = ''
      lid_state=$(cat /proc/acpi/button/lid/LID0/state | ${pkgs.gawk}/bin/awk '{print $NF}')

      if [ $lid_state = "closed" ]; then
        /run/wrappers/bin/sudo -u sen WAYLAND_DISPLAY=wayland-1 XDG_RUNTIME_DIR=/run/user/1000 \
        ${inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default}/bin/noctalia-shell ipc call lockScreen lock
        sleep 2

        systemctl suspend
      fi
    '';
  };

  specialisation.dgpu.configuration = {
    environment.sessionVariables = {
      LIBVA_DRIVER_NAME = "nvidia";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
#      ELECTRON_OZONE_PLATFORM_HINT = "auto";
#      NVD_BACKEND = "direct";
#      AQ_FORCE_LINEAR_BLIT = "0";
    };
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  environment.systemPackages = with pkgs; [
    grimblast

    (where-is-my-sddm-theme.override {
      themeConfig.General = {
        passwordFontSize = "18";
        passwordCursorColor = "#ffffff";
      };
    })
  ];
}
