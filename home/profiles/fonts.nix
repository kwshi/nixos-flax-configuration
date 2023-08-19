{ pkgs, ... }: {
  home.packages = with pkgs; [
    gtk2fontsel
    julia-mono
    nerdfonts
    stix-two
    xits-math
    eb-garamond
    garamond-libre

    line-awesome
    font-awesome
  ];
}
