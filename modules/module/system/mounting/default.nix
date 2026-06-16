{
  system = {
    services = {
      udisks2.enable = true;
      gvfs.enable = true;
    };
  };

  home = {
    services.udiskie = {
      enable = true;
      tray = "auto"; 
    };

    systemd.user.tmpfiles.rules = [
      "L+ %h/mnt/media - - - - /run/media/%u"
      "L+ %h/mnt/gvfs - - - - %t/gvfs"
    ];
  };
}
