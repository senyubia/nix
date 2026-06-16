{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    # applications
    vscode
    discord

    # cli tools
    dysk
    imv
    p7zip

    # system tools
    lshw
    powertop
    mesa-demos
  ];
}
