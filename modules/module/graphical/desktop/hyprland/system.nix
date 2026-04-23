{ pkgs, inputs, user, ... }: {
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };

  services.logind.settings.Login = {
    HandleLidSwitch = "ignore";
    #HandleLidSwitchExternalPower = "ignore";
    #HandleLidSwitchDocker = "ignore";
  };

  services.acpid = {
    enable = true;

    lidEventCommands = ''
      lid_state=$(cat /proc/acpi/button/lid/LID0/state | ${pkgs.gawk}/bin/awk '{print $NF}')

      if [ $lid_state = "closed" ]; then
        /run/wrappers/bin/sudo -u ${user.name} WAYLAND_DISPLAY=wayland-1 XDG_RUNTIME_DIR=/run/user/1000 \
        ${inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default}/bin/noctalia-shell ipc call lockScreen lock
        sleep 2

        systemctl suspend
      fi
    '';
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  environment.systemPackages = with pkgs; [
    grimblast
  ];
}
