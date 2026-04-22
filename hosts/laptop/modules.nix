{ modules }: [
  modules.group.base.system
  modules.group.base.programs.cli
  modules.group.base.programs.gui

  modules.system.bootloader.grub
  modules.system.gpu.nvidia-optimus
  modules.system.ssh

  modules.displaymanager.ly

  modules.desktop.hyprland.nvidia-optimus

  modules.config.stylix
]
