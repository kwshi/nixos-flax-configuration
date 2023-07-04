{ pkgs, ... }: {
  home.packages = with pkgs; [
    typst
    rmapi
    peek
    just
    pavucontrol
    unstable.webcord
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

    elmPackages.lamdera
    elmPackages.elm

    notion-app-enhanced
    # appflowy (depends on obsoleted openssl-1.1.1?)
    obsidian

    openscad

    tikzit

    gimp

    find-cursor

    foot
  ];
}
