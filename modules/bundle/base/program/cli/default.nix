{ modules }: {
  requires = [
    modules.program.cli.fastfetch
    modules.program.cli.nixutils
    modules.program.cli.git
    modules.program.cli.btop
    modules.program.cli.gnupg
  ];
}
