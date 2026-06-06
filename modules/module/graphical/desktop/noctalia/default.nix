{
  system = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      flake.noctalia
    ];
  };

  home.imports = [
    ./home.nix
  ];
}
