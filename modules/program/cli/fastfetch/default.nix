{
  system = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      fastfetch
    ];
  };

  home = { assets, ... }: {
    programs.fastfetch = {
      enable = true;

      settings = {
        logo = {
          type = "kitty-icat";
          source = "${assets}/logo.gif";
          width = 52;
        };

        display = {
          separator = " : ";
        };

        modules = [
          {
            type = "custom";
            format = "┌─────────────────────────────────────────────────┐";
          }
          {
            type = "title";
            key = "   Session";
            format = "{1}@{2}";
            keyColor = "red";
          }
          {
            type = "os";
            key = "   OS";
            keyColor = "red";
          }
          {
            type = "kernel";
            key = "   Kernel";
            format = "{2}";
            keyColor = "red";
          }
          {
            type = "packages";
            key = "  󰏖 Packages";
            keyColor = "red";
          }
          {
            type = "command";
            key = "  󱦟 Age";
            keyColor = "red";
            text = "birth_install=$(stat -c %W /); current=$(date +%s); time_progression=$((current - birth_install)); days_difference=$((time_progression / 86400)); echo $days_difference days";
          }
          {
            type = "uptime";
            key = "  󱫐 Uptime";
            keyColor = "red";
          }
          {
            type = "custom";
            format = "└─────────────────────────────────────────────────┘";
          }

          "break"

          {
            type = "custom";
            format = "┌─────────────────────────────────────────────────┐";
          }
          {
            type = "wm";
            key = "  󱗃 WM";
            keyColor = "yellow";
          }
          {
            type = "command";
            key = "  󰀻 Icons";
            keyColor = "yellow";
            text = "grep 'gtk-icon-theme-name' ~/.config/gtk-3.0/settings.ini | cut -d= -f2 | xargs";
          }
          {
            type = "command";
            key = "  󰛖 Font";
            keyColor = "yellow";
            text = ''r=$(grep 'gtk-font-name' ~/.config/gtk-3.0/settings.ini | cut -d= -f2 | xargs); echo "''${r% *} (''${r##* }pt)"'';
          }
          {
            type = "terminal";
            key = "   Terminal";
            keyColor = "yellow";
          }
          {
            type = "terminalfont";
            key = "   Terminal Font";
            keyColor = "yellow";
          }
          {
            type = "shell";
            key = "   Shell";
            keyColor = "yellow";
          }
          {
            type = "custom";
            format = "└─────────────────────────────────────────────────┘";
          }

          "break"

          {
            type = "custom";
            format = "┌─────────────────────────────────────────────────┐";
          }
          {
            type = "cpu";
            key = "   CPU";
            format = "{1}";
            keyColor = "blue";
          }
          {
            type = "gpu";
            key = "  󰊴 GPU";
            format = "{1} {2}";
            keyColor = "blue";
          }
          {
            type = "memory";
            key = "   Memory";
            keyColor = "blue";
          }
          {
            type = "custom";
            format = "└─────────────────────────────────────────────────┘";
          }

          "break"

          {
            type = "colors";
            paddingLeft = "2";
            symbol = "circle";
          }

          "break"
        ];
      };
    };
  };
}
