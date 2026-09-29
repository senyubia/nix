{
  system = { inputs, pkgs, user, assets, ... }: {
    imports = [
      inputs.noctalia-greeter.nixosModules.default
    ];

    services.displayManager.noctalia-greeter = {
      enable = true;

      settings = {
        appearance = {
          scheme = "Synced";
          scheme_selector_position = "hidden";

          password_style = "default";

          hide_logo = true;
        };

        cursor = {
          size = 16;
          theme = "Bibata-Modern-Ice";
        };

        keyboard.layout = "us";
      };

      cursorTheme.package = pkgs.bibata-cursors;

      passwordless-sync-users = [ "${user.name}" ];
    };

    services.accounts-daemon.enable = true;

    systemd.tmpfiles.settings."10-accountsservice" = {
      "/var/lib/AccountsService/icons/${user.name}"."L+" = {
        argument = "${assets}/pfp.png";
      };

      "/var/lib/AccountsService/users/${user.name}"."f+" = {
        argument = ''
          [User]
          Icon=/var/lib/AccountsService/icons/${user.name}
          SystemAccount=false
        '';
      };
    };
  };
}
