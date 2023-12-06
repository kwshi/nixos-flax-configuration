{
  programs.bash = {
    enable = true;
    enableCompletion = true;
    enableVteIntegration = true;
    shellAliases = {
      l = "eza";
      ll = "eza --long --all";
      g = "git";
      nrs = "sudo nixos-rebuild switch --fast";
    };
  };
}
