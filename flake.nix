{
  description = "System flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

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

  outputs = { nixpkgs, home-manager, ...} @ inputs:
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

      modules = [
        "${selectedHost}/configuration.nix"
        "${selectedHost}/hardware.nix"
      ] ++ systemModules;
    };

    homeConfigurations.${user.name} = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.${host.arch};

      extraSpecialArgs = { inherit inputs host user assets; };

      modules = [
        {
          home = {
            username = user.name;
            homeDirectory = "/home/${user.name}";
            stateVersion = host.state;
          };
        }
        "${selectedHost}/packages.nix"
      ] ++ userModules;
    };
  };
}
