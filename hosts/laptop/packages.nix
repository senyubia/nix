{ pkgs, ... }: {
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    # applications
    vscode
    feh
    discord

    # cli tools
    yazi
    dysk
    eza

    # system tools
    btop
    lshw
    powertop
    mesa-demos

    # nixos
    home-manager
  ];
}
