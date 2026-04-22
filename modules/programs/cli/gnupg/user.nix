{ pkgs, ... }: {
  programs.gpg = {
    enable = true;

    publicKeys = [
      {
        source = pkgs.fetchurl {
          url = "https://github.com/senyubia.gpg";
          sha256 = "sha256-b+0jxwoatrKgKH0YCR72aL1xZICFVvfom4FSdR1aj5Y=";
        };
        trust = 5;
      }
    ];
  };
}
