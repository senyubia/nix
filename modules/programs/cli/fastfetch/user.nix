{ assets, ... }: {
  programs.fastfetch = {
    enable = true;

    settings = {
      logo = {
        type = "kitty-icat";
        source = "${assets}/logo.gif";
        width = 36;
      };

      modules = [
        "title"
        "separator"

        "os"
        "kernel"
        "packages"
        "uptime"
        "separator"

        "wm"
        "icons"
        "font"
        "separator"

        "terminal"
        "terminalfont"
        "shell"
        "separator"

        "cpu"
        "gpu"
        "memory"
      ];
    };
  };
}
