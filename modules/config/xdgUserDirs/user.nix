{ config, ...}: {
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    setSessionVariables = true;

    documents = "${config.home.homeDirectory}/docs";
    download = "${config.home.homeDirectory}/downloads";
    music = "${config.home.homeDirectory}/music";
    pictures = "${config.home.homeDirectory}/pics";
    videos = "${config.home.homeDirectory}/vids";
    desktop = "${config.home.homeDirectory}/docs";
    publicShare = null;
    templates = null;
  };
}
