cfg: { inputs, host, user, ... }: {
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nixpkgs = {
    config.allowUnfree = true;

    overlays = [(final: prev: let
      stablePkgs = import inputs.nixpkgs-stable {
        system = host.arch;
        config.allowUnfree = true;
      };

      pinnedPkgs = builtins.mapAttrs (name: attr:
        (import (builtins.fetchTarball { inherit (attr) url sha256; }) {
          system = host.arch;
          config.allowUnfree = true;
        }).${name}) (import (cfg.selectedHost + "/pins.nix"));

      flakesPkgs = {
        noctalia = inputs.noctalia.packages.${host.arch}.default;
      };
    in
      pinnedPkgs // { stable = stablePkgs; flake = flakesPkgs; }
    )];
  };

  networking.hostName = host.name;

  users.users.${user.name} = {
    isNormalUser = true;
    description = user.fullName;
    extraGroups = [ "wheel" ];
  };

  system.stateVersion = host.state;
}
