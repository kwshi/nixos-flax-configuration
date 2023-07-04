{ pkgs, ... }: {
  home.packages = with pkgs; [
    gtk2fontsel
    julia-mono
    nerdfonts
    stix-two
    xits-math
  ];
}
