{
  system = { inputs, pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      nh

      (writeShellScriptBin "ns" ''
        if [ $# -eq 0 ]; then
          echo "Usage: ns <package1> <package2> ..."
          exit 1
        fi

        for arg do
          if [[ "$arg" == *#* ]]; then
            set -- "$@" "$arg"
          else
            set -- "$@" "${inputs.nixpkgs}#$arg"
          fi

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
