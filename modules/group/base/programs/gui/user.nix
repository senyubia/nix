{ modules, moduleImporter, ... }: {
  imports = moduleImporter.getUserModules (import ./modules.nix { inherit modules; });
}
