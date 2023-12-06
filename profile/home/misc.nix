{pkgs, ...}: {
  home.packages = with pkgs; [
    roc

    wl-clipboard

    typst
    rmapi
    peek
    just
    pavucontrol
    # https://github.com/NixOS/nixpkgs/issues/266879
    (webcord.override {electron_24 = electron_25;})
    ripgrep
    meson
    ninja
    tree-sitter
    nodePackages.prettier
    nodejs
    nodePackages.pnpm
    clang
    maim
    ffmpeg
    zoom-us

    pamixer
    pulseaudio

    slack-dark

    pup

    #elmPackages.lamdera
    #elmPackages.elm

    #notion-app-enhanced
    # appflowy (depends on obsoleted openssl-1.1.1?)
    #obsidian

    tikzit

    gimp
    inkscape

    find-cursor

    file
    zip
    unzip

    x11docker
  ];
}
