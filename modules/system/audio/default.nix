{
  system = {
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
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
