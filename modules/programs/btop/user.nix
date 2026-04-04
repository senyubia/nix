{
  programs.btop = {
    enable = true;

    settings = {
      force_tty = true;

      disks_filter = "exclude=/boot";
    };
  };
}
