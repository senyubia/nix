{ modules, ... }: {
  dependsOn = [
    modules.module.system.shells.zsh

    modules.module.programs.cli.fastfetch
    modules.module.programs.cli.nh
    modules.module.programs.cli.git
    modules.module.programs.cli.btop
    modules.module.programs.cli.gnupg
  ];
}
