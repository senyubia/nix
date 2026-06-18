{ modules }: {
  requires = [
    modules.system.network
    modules.system.audio
    modules.system.printing

    modules.config.locales
    modules.config.homedirs
  ];
}
