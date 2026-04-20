{ helpLib, ... }: {
  imports = [
    (helpLib.getUserModule "desktop/hyprland")
  ];
}
