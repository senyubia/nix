{
  system = {
    programs.yazi.enable = true;
  };

  home = { pkgs, ... }: {
    programs.yazi = {
      enable = true;
      extraPackages = with pkgs; [
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
        { on = [ "R" ]; run = "plugin recycle-bin"; desc = "Open Recycle Bin menu"; }

        # user defined
        { on = [ "g" "d" ]; run = "noop"; desc = "Disabled goto ~/Downloads"; }
      ];
    };
  };
}
