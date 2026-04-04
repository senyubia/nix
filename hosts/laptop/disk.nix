{
  disko.devices.disk.ssd = {
    device = "/dev/sda";
    type = "disk";

    content = {
      type = "gpt";

      partitions = {
        ESP = {
          type = "EF00";
          size = "512M";

          content = {
            type = "filesystem";
            format = "vfat";
            mountpoint = "/boot";
            mountOptions = [ "umask=0077" ];
          };
        };

        swap = {
          size = "8G";

          content = {
            type = "swap";
            resumeDevice = true;
          };
        };

        root = {
          size = "100G";

          content = {
            type = "filesystem";
            format = "ext4";
            mountpoint = "/";
          };
        };

        home = {
          size = "100%";

          content = {
            type = "filesystem";
            format = "ext4";
            mountpoint = "/home";
          };
        };
      };
    };
  };
}
