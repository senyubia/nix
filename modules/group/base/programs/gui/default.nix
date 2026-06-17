{ modules }: {
  requires = [
    modules.module.programs.gui.firefox
    modules.module.programs.gui.kitty
  ];
}
