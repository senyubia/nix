{
  system = { config, pkgs, lib, host, ... }: {
    nixpkgs.config.nvidia.acceptLicense = true;

    boot.blacklistedKernelModules = [ "nouveau" ];
    boot.kernelParams = [ "nvidia.NVreg_PreserveVideoMemoryAllocations=1" ];
    
    services.xserver.videoDrivers = [ "nvidia" ];

    hardware.nvidia = {
      modesetting.enable = true;

      prime = {
        intelBusId = host.intelBusId;
        nvidiaBusId = host.nvidiaBusId;

        sync.enable = false;
        offload.enable = true;
      };

      package = config.boot.kernelPackages.nvidiaPackages.legacy_580;
      open = false;
    };

    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };

    systemd.services.gpu-switching = {
      description = "Switch GPU";

      before = [ "display-manager.service" ];
      wantedBy = [ "display-manager.service" ];

      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = "yes";

        ExecStart = "${pkgs.writeShellScript "disable-dgpu" ''
          sleep 3
          ${pkgs.kmod}/bin/modprobe -r -f nvidia_drm nvidia_modeset
          echo 1 >> "/sys/bus/pci/devices/${host.nvidiaPciDevice}/remove"
        ''}";
      };
    };

    systemd.services.gpu-postsleep = {
      description = "Post sleep GPU hook";

      after = [ "systemd-suspend.service" "systemd-hybrid-sleep.service" "systemd-hibernate.service" ];
      wantedBy = [ "suspend.target" "hibernate.target" "hybrid-sleep.target" ];

      serviceConfig = {
        Type = "oneshot";

        ExecStart = "${pkgs.writeShellScript "gpu-postsleep-hook" ''
          sleep 3
          ${pkgs.kmod}/bin/modprobe -r -f nvidia_drm nvidia_modeset
          echo 1 >> "/sys/bus/pci/devices/${host.nvidiaPciDevice}/remove"
        ''}";
      };
    };

    specialisation.dgpu.configuration = {
      environment.etc."specialisation".text = "dgpu";

      hardware.nvidia = {
        prime = {
          sync.enable = lib.mkForce true;
          offload.enable = lib.mkForce false;
        };

        powerManagement.enable = true;
      };

      systemd.services.gpu-switching.serviceConfig.ExecStart = lib.mkForce "${pkgs.writeShellScript "enable-dgpu" ''
        echo 1 >> /sys/bus/pci/rescan
        sleep 3
        ${pkgs.kmod}/bin/modprobe nvidia_drm nvidia_modeset
      ''}";

      systemd.services.gpu-postsleep.serviceConfig.ExecStart = lib.mkForce "${pkgs.writeShellScript "gpu-postsleep-hook" ''
        exit 0
      ''}";
    };

    systemd.services.switch-to-intel = {
      description = "Switch to Intel GPU";

      serviceConfig = {
        Type = "oneshot";

        ExecStart = "${pkgs.writeShellScript "switch-intel" ''
          systemctl stop display-manager
          sleep 3
          /nix/var/nix/profiles/system/bin/switch-to-configuration test
        ''}";
      };
    };

    systemd.services.switch-to-nvidia = {
      description = "Switch to Nvidia GPU";

      serviceConfig = {
        Type = "oneshot";

        ExecStart = "${pkgs.writeShellScript "switch-nvidia" ''
          systemctl stop display-manager
          sleep 3
          /nix/var/nix/profiles/system/specialisation/dgpu/bin/switch-to-configuration test
        ''}";
      };
    };

    environment.systemPackages = with pkgs; [
      nvitop

      (writeShellScriptBin "gpu-toggle" ''
        if [ ! -d "/sys/bus/pci/devices/${host.nvidiaPciDevice}" ]; then
          SVC=switch-to-nvidia
        else
          SVC=switch-to-intel
        fi

        sudo systemctl start $SVC
      '')
    ];
  };
}
