{
  system = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      btop
    ];
  };

  home.programs.btop = {
    enable = true;

    settings = {
      force_tty = true;

      disks_filter = "exclude=/boot";
    };
  };
}
