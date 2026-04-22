{ root }: let
  mkModuleTree = path: let
    contents = builtins.readDir path;

    files =
      (if builtins.pathExists (path + "/system.nix")
      then { system = path + "/system.nix"; } else { }) //
      (if builtins.pathExists (path + "/user.nix")
      then { user = path + "/user.nix"; } else { });

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
  in
  files // dirs;

in {
  modules = mkModuleTree (root + "/modules");

  getSystemModules = mods: builtins.filter (m: m != null) (map (m: m.system or null) mods);
  getUserModules = mods: builtins.filter (m: m != null) (map (m: m.user or null) mods);
}
