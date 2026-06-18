{ modules }: {
  requires = [
    modules.program.gui.firefox
    modules.program.gui.kitty
  ];
}
