{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    # applications
    vscode
    discord

    # cli tools
    yazi
    dysk
    imv

    # system tools
    lshw
    powertop
    mesa-demos
  ];
}
