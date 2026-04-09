{
  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "senyubia";
        email = "108198161+senyubia@users.noreply.github.com";
      };

      commit = {
        gpgsign = true;
      };

      tag = {
        gpgsign = true;
      };
    };
  };
}
