{ nixpkgs, nixpkgs-stable, disko, home-manager, ...} @ inputs: let
  assets = ./assets;
  config = import ./config.nix;

  moduleImporter = import ./lib/moduleImporter.nix { root = ./.; lib = nixpkgs.lib; };

  inherit (import "${config.selectedHost}/info.nix") host user;

  allModules = moduleImporter.getAllModules;
  wantedModules = import "${config.selectedHost}/modules.nix" { modules = allModules; };
  wantedSystemModules = moduleImporter.getSystemModules wantedModules;
  wantedHomeModules = moduleImporter.getHomeModules wantedModules;

in {
  nixosConfigurations.${host.name} = nixpkgs.lib.nixosSystem {
    system = host.arch;

    specialArgs = {
      inherit inputs host user assets;
      modules = allModules;
    };

    modules = wantedSystemModules ++ [
      {
        nix.settings.experimental-features = [ "nix-command" "flakes" ];

        nixpkgs = {
          config.allowUnfree = true;

          overlays = [
            (final: prev: let
              stablePkgs = import nixpkgs-stable {
                system = host.arch;
                config.allowUnfree = true;
              };

              pinnedPkgs = builtins.mapAttrs (name: attr:
                (import (builtins.fetchTarball { inherit (attr) url sha256; }) {
                  system = host.arch;
                  config.allowUnfree = true;
                }).${name}) (import "${config.selectedHost}/pins.nix");
              
              flakesPkgs = {
                noctalia = inputs.noctalia.packages.${host.arch}.default;
              };
            in
              pinnedPkgs // { stable = stablePkgs; flake = flakesPkgs; }
            )
          ];
        };

        networking.hostName = host.name;

        users.users.${user.name} = {
          isNormalUser = true;
          description = user.fullName;
          extraGroups = [ "networkmanager" "wheel" ];
        };

        system.stateVersion = host.state;
      }

      "${config.selectedHost}/hardware.nix"
      "${config.selectedHost}/packages.nix"

      disko.nixosModules.disko
      "${config.selectedHost}/disk.nix"

      home-manager.nixosModules.home-manager
      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          backupFileExtension = "backup";

          extraSpecialArgs = {
            inherit inputs host user assets;
            modules = allModules;
          };

          users.${user.name}.imports = wantedHomeModules ++ [
            {
              home = {
                username = user.name;
                homeDirectory = "/home/${user.name}";
                stateVersion = host.state;
              };
            }
          ];
        };
      }
    ];
  };
}
