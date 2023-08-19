{config, ...}: {
  programs.ssh = {
    enable = true;
    matchBlocks = {
      "github.com" = {
        user = "git";
        identityFile = "${config.home.homeDirectory}/.ssh/keys/github";
      };
    };
  };
}
