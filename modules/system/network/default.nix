{
  system = { user, ... }: {
    networking.networkmanager.enable = true;

    users.users.${user.name}.extraGroups = [ "networkmanager" ];

    services.gvfs.enable = true;
  };
}
