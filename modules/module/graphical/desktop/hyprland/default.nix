{ modules }: {
  dependsOn = [
    modules.module.graphical.desktop.noctalia
  ];

  system.imports = [
    ./system.nix
  ];

  home.imports = [
    ./home.nix
  ];
}
