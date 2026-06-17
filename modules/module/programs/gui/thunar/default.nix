{
  system = {
    programs.thunar.enable = true;

    services = {
      gvfs.enable = true;
      tumbler.enable = true;
    };
  };
}
