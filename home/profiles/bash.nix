{
  programs.bash = {
    enable = true;
    enableCompletion = true;
    enableVteIntegration = true;
    shellAliases = {
      l = "exa";
      ll = "exa --long --all";
      g = "git";
      nrs = "sudo nixos-rebuild switch --fast";
    };
  };
}
