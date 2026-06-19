{
  system = {
    programs.yazi.enable = true;
  };

  home = { pkgs, ... }: {
    programs.yazi = {
      enable = true;
      extraPackages = with pkgs; [
        exiftool
        glib.bin
        trash-cli
      ];

      shellWrapperName = "y"; 
      enableBashIntegration = true;
      enableZshIntegration = true;

      settings.mgr = {
        sort_by = "natural";
        sort_sensitive = true;
        linemode = "mtime";
        show_symlink = false;
      };

      plugins = with pkgs.yaziPlugins; {
        gvfs = {
          package = gvfs;
          setup = true;
        };
        recycle-bin = {
          package = recycle-bin;
          setup = true;
        };
      };

      keymap.mgr.prepend_keymap = [
        # gvfs plugin
        { on = [ "M" "m" ]; run = "plugin gvfs -- select-then-mount --jump"; desc = "Select device to mount and jump to its mount point"; }
        { on = [ "M" "u" ]; run = "plugin gvfs -- select-then-unmount --eject"; desc = "Select device then eject"; }
        { on = [ "M" "U" ]; run = "plugin gvfs -- select-then-unmount --eject --force"; desc = "Select device then force eject"; }
        { on = [ "M" "j" ]; run = "plugin gvfs -- jump-to-device"; desc = "Select device then jump to its mount point"; }
        { on = [ "M" "b" ]; run = "plugin gvfs -- jump-back-prev-cwd"; desc = "Jump back to the position before jumped to device"; }
        { on = [ "M" "a" ]; run = "plugin gvfs -- add-mount"; desc = "Add a GVFS mount URI"; }
        { on = [ "M" "e" ]; run = "plugin gvfs -- edit-mount"; desc = "Edit a GVFS mount URI"; }
        { on = [ "M" "r" ]; run = "plugin gvfs -- remove-mount"; desc = "Remove a GVFS mount URI"; }

        # recycle-bin plugin
        { on = [ "D" ]; run = "plugin recycle-bin"; desc = "Open Recycle Bin menu"; }

        # user defined
        # unbinding
        { on = [ "j" ]; run = "noop"; desc = "Disable next file"; }
        { on = [ "k" ]; run = "noop"; desc = "Disable previous file"; }
        { on = [ "h" ]; run = "noop"; desc = "Disable back to the parent directory"; }
        { on = [ "l" ]; run = "noop"; desc = "Disable enter the child directory"; }
        { on = [ "<C-u>" ]; run = "noop"; desc = "Disable move cursor up half page"; }
        { on = [ "<C-d>" ]; run = "noop"; desc = "Disable move cursor down half page"; }
        { on = [ "<C-b>" ]; run = "noop"; desc = "Disable move cursor up one page"; }
        { on = [ "<C-f>" ]; run = "noop"; desc = "Disable move cursor down one page"; }
        { on = [ "g" "g" ]; run = "noop"; desc = "Disable go to top"; }
        { on = [ "G" ]; run = "noop"; desc = "Disable go to bottom"; }
        { on = [ "H" ]; run = "noop"; desc = "Disable back to previous directory"; }
        { on = [ "L" ]; run = "noop"; desc = "Disable forward to next directory"; }

        { on = [ "v" ]; run = "noop"; desc = "Disable enter visual mode (selection mode)"; }
        { on = [ "V" ]; run = "noop"; desc = "Disable enter visual mode (unset mode)"; }
        { on = [ "<C-r>" ]; run = "noop"; desc = "Disable invert selection of all files"; }

        { on = [ "y" ]; run = "noop"; desc = "Disabled copying"; }
        { on = [ "x" ]; run = "noop"; desc = "Disabled cutting"; }
        { on = [ "p" ]; run = "noop"; desc = "Disabled pasting"; }
        { on = [ "Y" ]; run = "noop"; desc = "Disabled clearing cut/copy status"; }
        { on = [ "X" ]; run = "noop"; desc = "Disabled clearing cut/copy status"; }
        { on = [ "P" ]; run = "noop"; desc = "Disable paste yanked files (overwrite if the destination exists)"; }
        { on = [ "-" ]; run = "noop"; desc = "Disabled symlinking the absolute path of yanked files"; }
        { on = [ "_" ]; run = "noop"; desc = "Disabled symlinking the relative path of yanked files"; }
        { on = [ "<C-->" ]; run = "noop"; desc = "Disabled hardlink yanked files"; }

        { on = [ "f" ]; run = "noop"; desc = "Disable filter files"; }
        { on = [ "/" ]; run = "noop"; desc = "Disable find next file"; }
        { on = [ "?" ]; run = "noop"; desc = "Disable find previous file"; }
        { on = [ "n" ]; run = "noop"; desc = "Disable next found"; }
        { on = [ "N" ]; run = "noop"; desc = "Disable previous found"; }
        { on = [ "s" ]; run = "noop"; desc = "Disable search files by name via fd"; }
        { on = [ "S" ]; run = "noop"; desc = "Disable search files by content via ripgrep"; }
        { on = [ "<C-s>" ]; run = "noop"; desc = "Disable cancel the ongoing search"; }
        { on = [ "z" ]; run = "noop"; desc = "Disable jump to a file/directory via fzf"; }
        { on = [ "Z" ]; run = "noop"; desc = "Disable jump to a directory via zoxide"; }
        { on = [ "g" "d" ]; run = "noop"; desc = "Disabled goto ~/Downloads"; }
        { on = [ "g" "c" ]; run = "noop"; desc = "Disable go to ~/.config"; }

        { on = [ "a" ]; run = "noop"; desc = "Disable create a file (ends with / for directories)"; }
        { on = [ "O" ]; run = "noop"; desc = "Disabled opening selected files interactively"; }
        { on = [ "<S-Enter>" ]; run = "noop"; desc = "Disabled entering interactively via Shift Enter"; }
        { on = [ ";" ]; run = "noop"; desc = "Disable run a shell command"; }
        { on = [ ":" ]; run = "noop"; desc = "Disable run a shell command (block until finishes)"; }

        { on = [ "J" ]; run = "noop"; desc = "Disable seek down 5 units in the preview"; }
        { on = [ "K" ]; run = "noop"; desc = "Disable seek up 5 units in the preview"; }
        { on = [ "w" ]; run = "noop"; desc = "Disable show task manager"; }
        { on = [ "~" ]; run = "noop"; desc = "Disable open help"; }

        { on = [ "<C-[>" ]; run = "noop"; desc = "Disable exit visual mode, clear selection, or cancel search"; }
        { on = [ "<C-z>" ]; run = "noop"; desc = "Disable suspend the process"; }

        # binding
        { on = [ "<Enter>" ]; run = "enter"; desc = "Enter the child directory"; }
        { on = [ "g" "n" ]; run = "cd ~/nix"; desc = "Go to ~/nix"; }

        { on = [ "<Space>" ]; run = "toggle"; desc = "Toggle the current selection state"; }

        { on = [ "<C-c>" ]; run = "yank"; desc = "Copy selected files"; }
        { on = [ "<C-x>" ]; run = "yank --cut"; desc = "Cut selected files"; }
        { on = [ "<C-v>" ]; run = "paste"; desc = "Paste files"; }
        { on = [ "V" ]; run = "paste --force"; desc = "Paste files (overwrite on conflicts)"; }
        { on = [ "<C-l>" "a" ]; run = "link"; desc = "Symlink the absolute path of selected files"; }
        { on = [ "<C-l>" "h" ]; run = "hardlink"; desc = "Hardlink selected files"; }
        { on = [ "<C-l>" "r" ]; run = "link --relative"; desc = "Symlink the relative path of selected files"; }

        { on = [ "<C-f>" ]; run = "filter --smart"; desc = "Search files by name"; }
        { on = [ "F" ]; run = "search --via=fd"; desc = "Search files recursively by name"; }
        { on = [ "<C-s>" ]; run = "search --via=rg"; desc = "Search files by content"; }

        { on = [ "n" ]; run = "create"; desc = "Create a file (ends with / for directories)"; }
        { on = [ "o" ]; run = "open --interactive"; desc = "Open selected files interactively"; }

        { on = [ "<Esc>" ]; run = [ "escape" "unyank" ]; desc = "Exit visual mode, clear selection, cancel search, clear cut/copy status"; }
        { on = [ "q" ]; run = "quit --no-cwd-file"; desc = "Quit without outputting cwd-file"; }
        { on = [ "Q" ]; run = "quit"; desc = "Quit the process"; }
      ];
    };
  };
}
