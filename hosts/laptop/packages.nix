{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    # applications
    vscode
    discord

    # cli tools
    yazi
    dysk
    eza
    imv

    # system tools
    btop
    lshw
    powertop
    mesa-demos
  ];
}
