let
  inherit (import ./lib.nix) compileCss;
in {
  programs.waybar = {
    enable = true;
    systemd = {enable = true;};
    settings = import ./settings.nix;
    style = compileCss (import ./style.nix);
  };
}
