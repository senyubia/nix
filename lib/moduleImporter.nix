{ root, lib }: let
  mkModuleTree = path: modules: let
    contents = builtins.readDir path;
    hasDefault = builtins.pathExists (path + "/default.nix");

    moduleDefinition = if hasDefault then import (path + "/default.nix") { inherit modules; }
      else { };

    dependsOn = moduleDefinition.dependsOn or [ ];

    node = {
      system = { ... }: {
        imports = (lib.optional hasDefault (moduleDefinition.system or { })) ++ (map (m: m.system) dependsOn);
      };

      home = { ... }: {
        imports = (lib.optional hasDefault (moduleDefinition.home or { })) ++ (map (m: m.home) dependsOn);
      };
    };

    subdirs = builtins.listToAttrs (
      builtins.concatMap (name: let
          subpath = path + "/${name}";
          type = contents.${name};
        in
          if type == "directory" then
          [ { name = name; value = mkModuleTree subpath modules; } ]
        else [ ]
      ) (builtins.attrNames contents)
    );

  in node // subdirs;

in {
  getAllModules = lib.makeExtensible (modules: mkModuleTree (root + "/modules") modules);
  getSystemModules = modules: map (m: m.system) modules;
  getHomeModules = modules: map (m: m.home) modules;
}
