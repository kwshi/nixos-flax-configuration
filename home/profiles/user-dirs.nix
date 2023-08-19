{ config, ... }: {
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  } // builtins.mapAttrs (_: value: "${config.home.homeDirectory}/${value}") {
    desktop = "desktop";
    documents = "documents";
    download = "downloads";
    music = "music";
    pictures = "pictures";
    publicShare = "public";
    templates = "templates";
    videos = "videos";
  };
}
