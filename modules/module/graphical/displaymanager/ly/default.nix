{
  system = { pkgs, ... }: {
    services.displayManager.ly.enable = true;

    systemd.services.switch-tty-postwake = {
      description = "Switch to tty1 after wake";

      after = [ "suspend.target" "hibernate.target" "hybrid-sleep.target" ];
      wantedBy = [ "suspend.target" "hibernate.target" "hybrid-sleep.target" ];

      serviceConfig = {
        Type = "oneshot";

        ExecStart = "${pkgs.kbd}/bin/chvt 1";
      };
    };
  };
}
