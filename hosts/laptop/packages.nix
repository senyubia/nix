{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    # applications
    vscode
    discord
    lutris
    steam

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
