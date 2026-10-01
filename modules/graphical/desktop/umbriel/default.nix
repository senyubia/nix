{ modules }: {
  requires = [
    modules.graphical.desktop.noctalia
  ];

  system = { inputs, pkgs, user, ... }: {
    imports = [
      inputs.umbriel.nixosModules.default
    ];

    programs.umbriel.enable = true;

    services.logind.settings.Login = {
      HandleLidSwitch = "ignore";
    };

    services.acpid = {
      enable = true;

      lidEventCommands = ''
        lid_state=$(cat /proc/acpi/button/lid/LID0/state | ${pkgs.gawk}/bin/awk '{print $NF}')

        if [ $lid_state = "closed" ]; then
          /run/wrappers/bin/sudo -u ${user.name} WAYLAND_DISPLAY=wayland-0 XDG_RUNTIME_DIR=/run/user/1000 \
          ${pkgs.flake.noctalia}/bin/noctalia msg session lock
          sleep 2

          systemctl suspend
        fi
      '';
    };
  };

  home = { inputs, host, ... }: {
    imports = [
      inputs.umbriel.homeModules.default
    ];

    programs.umbriel = {
      enable = true;

      settings = {
        general = {
          show_cheatsheet = false;

          autostart = [
            "noctalia"
          ];

          xwayland_native_resolution = true;
        };

        layout = {
          mode = "dwindle";
          gap = 5;

          scrolling = {
            default_extent_fraction = 0.5;
            center_focused = "on_overflow";
          };
        };

        input = {
          middle_click_paste = false;

          keyboard.layout = "";

          touchpad = {
            tap = false;

            accel_profile = "flat";
            
            natural_scroll = false;
            scroll_factor = 1.0;

            disable_while_typing = false;
            disable_on_external_mouse = true;
          };

          mouse = {
            accel_profile = "flat";
          };

          cursor = {
            size = 16;
            hardware_cursor = true;
          };

          focus = {
            follows_mouse = true;
          };
        };

        output.${host.monitor} = {
          workspaces = 10;
        };

        keybinds = {
          "XF86AudioRaiseVolume" = "spawn:noctalia msg volume-up";
          "XF86AudioLowerVolume" = "spawn:noctalia msg volume-down";
          "XF86AudioMute" = "spawn:noctalia msg volume-mute";
          "XF86AudioMicMute" = "spawn:noctalia msg mic-mute";

          "XF86MonBrightnessUp" = "spawn:noctalia msg brightness-up";
          "XF86MonBrightnessDown" = "spawn:noctalia msg brightness-down";

          "Print" = "spawn:noctalia msg screenshot-fullscreen";
          "Ctrl+Print" = "spawn:noctalia msg screenshot-region";

          "Mod" = "spawn:noctalia msg panel-toggle control-center";
          "Mod+D" = "spawn:noctalia msg panel-toggle launcher";
          "Mod+L" = "spawn:noctalia msg session lock";

          "Mod+Return" = "spawn:kitty";
          "Mod+Q" = "window-close";
          "Mod+F" = "window-toggle-fullscreen";
          "Mod+M" = "window-toggle-maximize";
          "Mod+Space" = "window-toggle-floating";

          "Mod+Tab" = "overview-toggle";

          "Mod+Left" = "window-focus-left";
          "Mod+Down" = "window-focus-down";
          "Mod+Up" = "window-focus-up";
          "Mod+Right" = "window-focus-right";
          
          "Mod+WheelUp" = "window-focus-left";
          "Mod+WheelDown" = "window-focus-right";
          "Mod+Shift+WheelUp" = "workspace-previous";
          "Mod+Shift+WheelDown" = "workspace-next";

          "Mod+Shift+Left" = "window-consume-or-expel-left";
          "Mod+Shift+Down" = "window-move-down";
          "Mod+Shift+Up" = "window-move-up";
          "Mod+Shift+Right" = "window-consume-or-expel-right";

          "Mod+Alt+1" = "workspace-set-layout:dwindle";
          "Mod+Alt+2" = "workspace-set-layout:scrolling";
          "Mod+Alt+3" = "workspace-set-layout:master";

          "Mod+1" = "workspace-switch:1";
          "Mod+2" = "workspace-switch:2";
          "Mod+3" = "workspace-switch:3";
          "Mod+4" = "workspace-switch:4";
          "Mod+5" = "workspace-switch:5";
          "Mod+6" = "workspace-switch:6";
          "Mod+7" = "workspace-switch:7";
          "Mod+8" = "workspace-switch:8";
          "Mod+9" = "workspace-switch:9";
          "Mod+0" = "workspace-switch:10";

          "Mod+Shift+1" = "window-move-to-workspace:1";
          "Mod+Shift+2" = "window-move-to-workspace:2";
          "Mod+Shift+3" = "window-move-to-workspace:3";
          "Mod+Shift+4" = "window-move-to-workspace:4";
          "Mod+Shift+5" = "window-move-to-workspace:5";
          "Mod+Shift+6" = "window-move-to-workspace:6";
          "Mod+Shift+7" = "window-move-to-workspace:7";
          "Mod+Shift+8" = "window-move-to-workspace:8";
          "Mod+Shift+9" = "window-move-to-workspace:9";
          "Mod+Shift+0" = "window-move-to-workspace:10";
        };
      };
    };
  };
}
