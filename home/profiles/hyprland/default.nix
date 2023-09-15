{pkgs, ...}: {
  wayland.windowManager.hyprland = {
    enable = true;
    #settings = {
    #  input = {
    #    kb_layout = "us";
    #    kb_variant = "workman";
    #    kb_options = "ctrl:nocaps,altwin:swap_alt_win";
    #  };
    #  bind = [
    #    "SUPER, 1, workspace, 1"
    #    "SUPER, 2, workspace, 2"
    #    "SUPER, 3, workspace, 3"
    #    "SUPER, 4, workspace, 4"
    #    "SUPER, 5, workspace, 5"
    #    "SUPER, return, exec, foot"
    #  ];
    #};
    extraConfig = builtins.readFile ./hyprland.conf;
  };
  home.packages = [pkgs.wl-clipboard];
}
