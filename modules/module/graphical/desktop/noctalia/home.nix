{ config, inputs, assets, ... }: {
  imports = [
    inputs.noctalia.homeModules.default
  ];

  programs.noctalia-shell = {
    enable = true;

    settings = {
      general = {
        avatarImage = "${assets}/logo.gif";
        lockOnSuspend = true;
      };

      bar = {
        density = "compact";
        position = "top";
        showCapsule = false;
        widgets = {
          left = [
            { id = "ControlCenter"; useDistroLogo = true; }
          ];

          center = [
            {
              id = "Workspace";
              labelMode = "none";
              hideUnoccupied = false;
            }
          ];

          right = [
            {
              id = "Tray";
              blacklist = [ ];
              chevronColor = "none";
            }
            {
              id = "Battery";
              displayMode = "graphic";
              hideIfNotDetected = false;
            }
            {
              id = "Clock";
              formatHorizontal = "HH:mm";
              formatVertical = "HH mm";
              useMonospacedFont = true;
              usePrimaryColor = true;
            }
          ];
        };
      };

      dock = {
        enabled = false;
      };

      calendar = {
        cards = [
          { id = "calendar-header-card"; enabled = true; }
          { id = "calendar-month-card"; enabled = true; }
        ];
      };

      controlCenter = {
        position = "close_to_bar_button";
        shortcuts = {
          left = [
            { id = "Network"; }
            { id = "Bluetooth"; }
            { id = "Notifications"; }
            { id = "KeepAwake"; }
            { id = "NightLight"; }
          ];

          right = [ ];
        };

        cards = [
          { id = "profile-card"; enabled = true; }
          { id = "shortcuts-card"; enabled = true; }
          { id = "audio-card"; enabled = true; }
          { id = "brightness-card"; enabled = true; }
          { id = "media-sysmon-card"; enabled = true; }
        ];
      };

      location = {
        weatherEnabled = false;
        firstDayOfWeek = "1";
        autoLocate = false;
      };

      brightness = {
        enforceMinimum = false;
      };

      nightLight = {
        autoSchedule = false;
        manualSunrise = "06:00";
        manualSunset = "23:00";
      };

      wallpaper = {
        directory = "${config.home.homeDirectory}/pics/wp";
        transitionType = [ ];
      };

      sessionMenu = {
        enableCountdown = false;

        powerOptions = [
          { action = "logout"; enabled = true; keybind = "1"; }
          { action = "reboot"; enabled = true; keybind = "2"; }
          { action = "shutdown"; enabled = true; keybind = "3"; }
        ];
      };
    };

    plugins = {
      sources = [
        {
          enabled = true;
          name = "Noctalia Plugins";
          url = "https://github.com/noctalia-dev/noctalia-plugins";
        }
      ];

      states = {
        polkit-agent = {
          enabled = true;
          sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
        };
      };

      version = 2;
    };
  };
}
