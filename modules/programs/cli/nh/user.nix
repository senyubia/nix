{ user, pkgs, ... }: {
  programs.nh = {
    enable = true;
    flake = "/home/${user.name}/nix";
  };
}
