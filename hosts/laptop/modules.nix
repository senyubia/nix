{ modules }: [
  modules.bootloader.grub

  modules.system.network
  modules.system.audio
  modules.system.nvidia-optimus
  modules.system.printing
  modules.system.bluetooth
  modules.system.battery
  modules.system.ssh

  modules.shells.zsh

  modules.programs.firefox
  modules.programs.fastfetch
  modules.programs.kitty
  modules.programs.nh
  modules.programs.thunar
  modules.programs.git
  modules.programs.btop
  modules.programs.gnupg

  modules.displaymanager.ly

  modules.desktop.hyprland-nvidia-optimus

  modules.config.locales
  modules.config.xdgUserDirs
  modules.config.stylix
]
