{
  system = { user, ... }: {
    virtualisation.virtualbox.host.enable = true;
    # virtualisation.virtualbox.host.enableExtensionPack = true;

    users.users.${user.name}.extraGroups = [ "vboxusers" ];
  };
}
