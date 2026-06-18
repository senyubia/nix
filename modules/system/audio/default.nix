{
  system = {
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;

      extraConfig.pipewire = {
        "92-low-latency" = {
          "context.properties" = {
            "default.clock.rate" = 48000;
            "default.clock.quantum" = 128;
            "default.clock.min-quantum" = 32;
            "default.clock.max-quantum" = 512;
          };
        };
      };

      wireplumber.extraConfig = {
        "10-bluetooth-policy" = {
          "monitor.bluez.properties" = {
            "bluez5.enable-sbc-xq" = true; 
            "bluez5.default.rate" = 48000;
          };
        };
      };
    };

    security.rtkit.enable = true;
  };

  home = {
    services.fluidsynth = {
      enable = true;
      soundService = "pipewire-pulse";
    };
  };
}
