{ pkgs, ... }: {
  home.packages = with pkgs; [
    # applications
    vscode
    discord

    # cli tools
    yazi
    dysk
    eza
    imv

    # system tools
    lshw
    powertop
    mesa-demos
  ];
}
