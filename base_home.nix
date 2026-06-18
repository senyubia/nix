homeModules: { inputs, host, user, assets, ... }: {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";

    extraSpecialArgs = {
      inherit inputs host user assets;
    };

    users.${user.name}.imports = homeModules ++ [
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
