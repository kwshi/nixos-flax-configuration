{config, ...}: {
  programs.ssh = {
    enable = true;
    matchBlocks = {
      "github.com" = {
        user = "git";
        identityFile = "${config.home.homeDirectory}/.ssh/keys/github";
      };
      "arky.kshi.xyz" = {
        identityFile = "${config.home.homeDirectory}/.ssh/keys/arky";
      };
      "laguna.pic.ucla.edu" = {
        user = "kwshi";
        identityFile = "${config.home.homeDirectory}/.ssh/keys/kwshi@laguna.pic.ucla.edu";
      };
      "git.sr.ht" = {
        user = "kwshi";
        identityFile = "${config.home.homeDirectory}/.ssh/keys/sr.ht";
      };
    };
  };
}
