{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
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
  ];
}
