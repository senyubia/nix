{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    # applications
    vscode
    discord

    # cli tools
    yazi
    dysk
    imv
    micro

    # system tools
    lshw
    powertop
    mesa-demos
  ];
}
