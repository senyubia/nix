{
  system = { pkgs, ... } : {
    environment = {
      systemPackages = with pkgs; [
        micro
      ];

      sessionVariables = {
        EDITOR = "micro";
        VISUAL = "micro";
      };
    };
  };

  home = {
    programs.micro.enable = true;
  };
}
