{ pkgs, ... }: {
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    # applications
    vscode
    feh
    discord

    # cli tools
    tree
    yazi

    # system tools
    btop
    lshw
    powertop
    mesa-demos

    # nixos
    home-manager
  ];
}
