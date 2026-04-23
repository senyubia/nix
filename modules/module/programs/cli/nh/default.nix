{
  system = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      nh

      (writeShellScriptBin "ns" ''
        if [ $# -eq 0 ]; then
          echo "Usage: ns <package1> <package2> ..."
          exit 1
        fi

        for arg do
          set -- "$@" "nixpkgs#$arg"
          shift
        done

        exec nix shell "$@"
      '')
    ];
  };

  home = { user, ... }: {
    programs.nh = {
      enable = true;
      flake = "/home/${user.name}/nix";
    };
  };
}
