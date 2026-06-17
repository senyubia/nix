{ modules }: {
  requires = [
    modules.module.programs.cli.fastfetch
    modules.module.programs.cli.nixutils
    modules.module.programs.cli.git
    modules.module.programs.cli.btop
    modules.module.programs.cli.gnupg
  ];
}
