{
  description = "System flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-26.05";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia/legacy-v4";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, disko, home-manager, ... } @ inputs: let
    assets = ./assets;
    cfg = import ./config.nix;

    moduleImporter = import ./lib/moduleImporter.nix { root = ./.; lib = nixpkgs.lib; };

    inherit (import (cfg.selectedHost + "/info.nix")) host user;

    allModules = moduleImporter.getAllModules;
    wantedModules = import (cfg.selectedHost + "/modules.nix") { modules = allModules; };
    wantedSystemModules = moduleImporter.getSystemModules wantedModules;
    wantedHomeModules = moduleImporter.getHomeModules wantedModules;
  in {
    nixosConfigurations.${host.name} = nixpkgs.lib.nixosSystem {
      system = host.arch;

      specialArgs = {
        inherit inputs host user assets;
      };

      modules = wantedSystemModules ++ [
        (import ./base_system.nix cfg)
        (import ./base_home.nix wantedHomeModules)

        (cfg.selectedHost + "/hardware.nix")
        (cfg.selectedHost + "/packages.nix")
        (cfg.selectedHost + "/disk.nix")

        disko.nixosModules.disko 
        home-manager.nixosModules.home-manager 
      ];
    };
  };
}
