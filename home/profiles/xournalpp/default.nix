{pkgs, ...}: {
  # gnome3.adwaita-icon-theme needed because, without it, xournalpp crashes on startup (issue threads say it's fixed, but it's not…)
  # https://github.com/NixOS/nixpkgs/issues/63715
  # https://github.com/NixOS/nixpkgs/issues/63089#issuecomment-502201837
  # https://github.com/NixOS/nixpkgs/issues/163107
  home.packages = with pkgs; [xournalpp gnome3.adwaita-icon-theme];
}
