{ root }: let
  getSystemModules = modules: builtins.filter (m: m != null) (map (m: m.system or null) modules);
  getHomeModules = modules: builtins.filter (m: m != null) (map (m: m.home or null) modules);

  mkModuleTree = path: let
    contents = builtins.readDir path;
    hasGroup = builtins.pathExists (path + "/group.nix");
    hasSystem = builtins.pathExists (path + "/system.nix");
    hasHome = builtins.pathExists (path + "/home.nix");

    system =
      if hasGroup && hasSystem then { modules, ... }: {
        imports = [ (path + "/system.nix") ] ++ (getSystemModules (import (path + "/group.nix") { inherit modules; }));
      }
      else if hasGroup then { modules, ... }: {
        imports = getSystemModules (import (path + "/group.nix") { inherit modules; });
      }
      else if hasSystem then (path + "/system.nix")
      else null;

    home =
      if hasGroup && hasHome then { modules, ... }: {
        imports = [ (path + "/home.nix") ] ++ (getHomeModules (import (path + "/group.nix") { inherit modules; }));
      }
      else if hasGroup then { modules, ... }: {
        imports = getHomeModules (import (path + "/group.nix") { inherit modules; });
      }
      else if hasHome then (path + "/home.nix")
      else null;

    dirs = builtins.listToAttrs (
      builtins.concatMap (name: let
          subpath = path + "/${name}";
          type = contents.${name};
        in
          if type == "directory" then
            [ { name = name; value = mkModuleTree subpath; } ]
          else [ ]
      ) (builtins.attrNames contents)
    );

  in {
    inherit system home;
  } // dirs;

in {
  inherit getSystemModules getHomeModules;
  modules = mkModuleTree (root + "/modules");
}
