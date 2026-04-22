{ modules }: [
  modules.group.base.system
  modules.group.base.programs.cli
  modules.group.base.programs.gui

  modules.module.system.bootloader.grub
  modules.module.system.gpu.nvidia-optimus
  modules.module.system.ssh

  modules.module.graphical.displaymanager.ly
  modules.module.graphical.desktop.hyprland.nvidia-optimus

  modules.module.config.stylix

  modules.module.programs.gui.gaming
]
