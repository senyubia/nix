{ modules }: [
  # bundles
  modules.bundle.base.system
  modules.bundle.base.program.cli
  modules.bundle.base.program.gui

  # system
  modules.system.bootloader.grub
  modules.system.gpu.nvidia_optimus
  modules.system.bluetooth
  modules.system.battery
  modules.system.ssh
  modules.system.elevation.sudo

  # ui
  modules.graphical.displaymanager.ly
  modules.graphical.desktop.hyprland.nvidia_optimus
  modules.config.stylix

  # base apps
  modules.system.shell.zsh
  modules.program.cli.editor.micro
  modules.program.cli.yazi

  # extra
  modules.program.gui.gaming
]
