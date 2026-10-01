{ modules }: {
  requires = [
    modules.graphical.desktop.umbriel
  ];

  system = {
    specialisation.dgpu.configuration.environment.sessionVariables = {
      LIBVA_DRIVER_NAME = "nvidia";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    };
  };
}
