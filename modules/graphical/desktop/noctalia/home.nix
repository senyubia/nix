{ config, inputs, assets, ... }: {
  imports = [
    inputs.noctalia.homeModules.default
  ];

  programs.noctalia = {
    enable = true;

    settings = {
      shell = {
        avatar_path = "${assets}/pfp.png";

        session.actions = [
          { action = "lock"; enabled = false; }
          { action = "logout"; shortcut = ""; }
          { action = "lock_and_suspend"; enabled = false; }
          { action = "reboot"; shortcut = ""; }
          { action = "shutdown"; shortcut = ""; variant = "destructive"; }
        ];

        offline_mode = true;
        polkit_agent = true;
        show_location = false;

        clipboard_enabled = false;

        window_switcher = {
          style = "compact";
        };

        screen_corners = {
          enabled = true;
        };

        screenshot = {
          annotate = true;
          save_to_file = false;
        };

        greeter_sync = {
          auto_sync = true;
        };
      };

      lockscreen = {
        fingerprint = false;
        lock_before_suspend = false;
        transition = [ ];
      };

      bar.main = {
        position = "top";
        capsule = false;
        thickness = 28;
        margin_ends = 0;

        start = [ "control-center" ];
        center = [ "workspaces" ];
        end = [ "tray" "battery" "clock" ];
      };

      widget = {
        control-center = {
          custom_image = "${assets}/nixos.png";
          scale = 1.1;
        };

        workspaces = {
          hide_when_empty = false;
          show_labels = false;
          show_tooltip = false;
          pill_scale = 0.8;
        };

        tray = {
          drawer = false;
        };

        battery = {
          display_mode = "graphic";
          hide_when_full = false;
        };
      };

      dock = {
        enabled = false;
      };

      control_center = {
        sidebar = "none";
        sidebar_section = "none";

        shortcuts = [
          { type = "wifi"; }
          { type = "bluetooth"; }
          { type = "audio"; }
          { type = "mic_mute"; }
        ];
      };

      battery = {
        warning_threshold = 20;
      };

      desktop_widgets = {
        enabled = false;
      };

      nightlight = {
        enabled = false;
      };

      weather = {
        enabled = false;
      };

      wallpaper = {
        directory = "${config.home.homeDirectory}/pics/wp";
        transition = [ ];
      };

      hooks = {
        started = "noctalia msg greeter-sync";
      };
    };
  };
}
