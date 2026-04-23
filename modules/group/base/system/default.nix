{ modules, ... }: {
  dependsOn = [
    modules.module.system.network
    modules.module.system.audio
    modules.module.system.printing
    modules.module.system.bluetooth
    modules.module.system.battery

    modules.module.config.locales
    modules.module.config.xdgUserDirs
  ];
}
