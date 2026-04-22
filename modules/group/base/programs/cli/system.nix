{ modules, moduleImporter, ... }: {
  imports = moduleImporter.getSystemModules (import ./modules.nix { inherit modules; });
}
