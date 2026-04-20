{ root }: let
  getModuleFile = fileName: moduleName:
    let path = root + "/modules/${moduleName}/${fileName}";
    in if builtins.pathExists path then [ path ] else [ ];

in {
  getSystemModule = module: getModuleFile "system.nix" module;
  getUserModule = module: getModuleFile "user.nix" module;
}
