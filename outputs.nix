{ nixpkgs, nixpkgs-stable, disko, home-manager, ...} @ inputs: let
  assets = ./assets;
  config = import ./config.nix;

  moduleImporter = import ./lib/moduleImporter.nix { root = ./.; };

  inherit (import "${config.selectedHost}/info.nix") host user;

  hostModules = import "${config.selectedHost}/modules.nix" { modules = moduleImporter.modules; };
  systemModules = moduleImporter.getSystemModules hostModules;
  userModules = moduleImporter.getUserModules hostModules;

in {
  nixosConfigurations.${host.name} = nixpkgs.lib.nixosSystem {
    system = host.arch;

    specialArgs = {
      inherit inputs moduleImporter host user assets;
      modules = moduleImporter.modules;
    };

    modules = systemModules ++ [
      {
        nix.settings.experimental-features = [ "nix-command" "flakes" ];

        nixpkgs = {
          config.allowUnfree = true;

          overlays = [
            (final: prev: {
              stable = import nixpkgs-stable {
                system = host.arch;
                config.allowUnfree = true;
              };
            })
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
            inherit inputs moduleImporter host user assets;
            modules = moduleImporter.modules;
          };

          users.${user.name}.imports = userModules ++ [
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
