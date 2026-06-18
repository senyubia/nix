{ modules }: {
  requires = [
    modules.graphical.desktop.noctalia
  ];

  system = {
    imports = [
      ./system.nix
    ];
  };

  home = {
    imports = [
      ./home.nix
    ];
  };
}
