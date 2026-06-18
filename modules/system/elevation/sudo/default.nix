{
  system = {
    security.sudo = {
      enable = true;

      extraConfig = ''
        Defaults passwd_timeout=0
        Defaults timestamp_timeout=60
        Defaults timestamp_type=global
        Defaults pwfeedback
      '';
    };
  };
}
