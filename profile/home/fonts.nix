{pkgs, ...}: {
  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    gtk2fontsel
    julia-mono
    nerdfonts
    stix-two
    xits-math
    eb-garamond
    garamond-libre
    libertinus

    line-awesome
    font-awesome

    source-han-serif
    source-han-sans
    noto-fonts-cjk
    i-dot-ming
    babelstone-han
  ];
}
