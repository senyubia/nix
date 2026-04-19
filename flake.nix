{
  description = "System flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.11";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, nixpkgs-stable, disko, home-manager, ...} @ inputs:
  let
    getModuleFile = fileName: moduleName:
      let path = ./. + "/modules/${moduleName}/${fileName}";
      in if builtins.pathExists path then [ path ] else [ ];


    selectedHost = ./hosts/laptop; # TODO: select correct host
    assets = ./assets;
    inherit (import "${selectedHost}/info.nix") host user;

    hostModules = import "${selectedHost}/modules.nix";
    systemModules = builtins.concatLists (map (getModuleFile "system.nix") hostModules.modules);
    userModules = builtins.concatLists (map (getModuleFile "user.nix") hostModules.modules);
  in {
    nixosConfigurations.${host.name} = nixpkgs.lib.nixosSystem {
      system = host.arch;

      specialArgs = { inherit inputs host user assets; };

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

        "${selectedHost}/hardware.nix"
        "${selectedHost}/packages.nix"

        disko.nixosModules.disko
        "${selectedHost}/disk.nix"

        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            backupFileExtension = "backup";

            extraSpecialArgs = { inherit inputs host user assets; };

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
  };
}
