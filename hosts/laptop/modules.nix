{ modules }: [
  modules.bundle.base.system
  modules.bundle.base.program.cli
  modules.bundle.base.program.gui

  modules.system.bootloader.grub
  modules.system.gpu.nvidia-optimus
  modules.system.bluetooth
  modules.system.battery
  modules.system.ssh
  modules.system.elevation.sudo

  modules.graphical.displaymanager.ly
  modules.graphical.desktop.hyprland.nvidia-optimus

  modules.system.shell.zsh
  modules.program.cli.editor.micro
  modules.program.cli.yazi

  modules.config.stylix

  modules.program.gui.gaming
]
