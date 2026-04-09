{ config, inputs, assets, host, ... }: {
  imports = [
    inputs.noctalia.homeModules.default
  ];
  
  wayland.windowManager.hyprland = {
    enable = true;  
    
    settings = {
      monitor = [
        "eDP-1,${host.resolution}@${host.refreshRate},auto,auto"
        ",${host.resolution}@60,auto,1,mirror,eDP-1"
      ];

      exec-once = [
        "noctalia-shell &"
      ];

      general = {
        gaps_in = 5;
        gaps_out = 10;

        border_size = 2;
        resize_on_border = false;

        allow_tearing = false;

        layout = "dwindle";
      };

      decoration = {
        rounding = 10;
        rounding_power = 2;

        inactive_opacity = 0.6;

        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
        };

        blur = {
          enabled = true;

          size = 3;
          passes = 1;

          vibrancy = 0.1696;
        };
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      misc = {
        force_default_wallpaper = 0;
        disable_hyprland_logo = true;
      };

      input = {
        kb_layout = "us";

        follow_mouse = 1;
        sensitivity = 0;
        accel_profile = "flat";

        touchpad = {
          natural_scroll = false;
          tap-to-click = false;
        };
      };

      workspace = [
        "1, persistent:true"
        "2, persistent:true"
        "3, persistent:true"
        "4, persistent:true"
        "5, persistent:true"
        "6, persistent:true"
        "7, persistent:true"
        "8, persistent:true"
        "9, persistent:true"
        "10, persistent:true"
      ];

      "$mod" = "SUPER";
      "$ipc" = "noctalia-shell ipc call";
      bind = [
        ", XF86AudioRaiseVolume, exec, $ipc volume increase"
        ", XF86AudioLowerVolume, exec, $ipc volume decrease"
        ", XF86AudioMute, exec, $ipc volume muteOutput"
        ", XF86AudioMicMute, exec, $ipc volume muteInput"

        ", XF86MonBrightnessUp, exec, $ipc brightness increase"
        ", XF86MonBrightnessDown, exec, $ipc brightness decrease"

        ", PRINT, exec, grimblast save area"
        "CONTROL, PRINT, exec, grimblast copy area"

        "$mod, SUPER_L, exec, $ipc controlCenter toggle"
        "$mod, D, exec, $ipc launcher toggle"
        "$mod, L, exec, $ipc lockScreen lock"
        "$mod, W, exec, $ipc wallpaper toggle"

        "$mod, RETURN, exec, kitty"
        "$mod, Q, killactive,"
        "$mod, F, fullscreen"
        "$mod, H, layoutmsg, togglesplit"
        "$mod, J, pseudo,"
        "$mod, Space, togglefloating"

        "$mod, Left, movefocus, l"
        "$mod, Down, movefocus, d"
        "$mod, Up, movefocus, u"
        "$mod, Right, movefocus, r"

        "$mod SHIFT, Left, movewindow, l"
        "$mod SHIFT, Down, movewindow, d"
        "$mod SHIFT, Up, movewindow, u"
        "$mod SHIFT, R2ight, movewindow, r"

        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod, 0, workspace, 10"

        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
        "$mod SHIFT, 6, movetoworkspace, 6"
        "$mod SHIFT, 7, movetoworkspace, 7"
        "$mod SHIFT, 8, movetoworkspace, 8"
        "$mod SHIFT, 9, movetoworkspace, 9"
        "$mod SHIFT, 0, movetoworkspace, 10"
      ];

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];
    };

    extraConfig = ''
      layerrule {
        name = noctalia
        match:namespace = noctalia-background-.*$
        ignore_alpha = 0.5
        blur = true
        blur_popups = true
      }
    '';
  };

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
