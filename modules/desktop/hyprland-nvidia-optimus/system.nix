{ helpLib, ... }: {
  imports = helpLib.getSystemModule "desktop/hyprland";

  specialisation.dgpu.configuration = {
    environment.sessionVariables = {
      LIBVA_DRIVER_NAME = "nvidia";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
#      ELECTRON_OZONE_PLATFORM_HINT = "auto";
#      NVD_BACKEND = "direct";
#      AQ_FORCE_LINEAR_BLIT = "0";
    };
  };
}
