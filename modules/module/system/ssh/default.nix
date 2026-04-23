{ ... }: {
  system = { user, ... }: {
    services.openssh = {
      enable = true;
      ports = [ 26184 ];

      settings = {
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
        PermitRootLogin = "no";
        AllowUsers = [ "${user.name}@192.168.0.0/16" ];
      };
    };

    services.fail2ban = {
      enable = true;

      maxretry = 5;
      bantime = "1h";
    };

    services.endlessh = {
      enable = true;

      port = 22;
      openFirewall = true;
    };

    users.users.${user.name}.openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIRL0iNEr0sogP6nhhWc9jM24/hZUVRjiaw6fPkgphpp openpgp:0xAD7C1DE1"
    ];
  };
}
