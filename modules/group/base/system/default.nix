{ modules }: {
  requires = [
    modules.module.system.network
    modules.module.system.audio
    modules.module.system.printing
    modules.module.system.mounting

    modules.module.config.locales
    modules.module.config.homedirs
  ];
}
