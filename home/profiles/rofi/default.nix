{ pkgs, ... }: {
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland.override {
      plugins = with pkgs; [
        rofimoji
        rofi-emoji
        rofi-file-browser
      ];
    };

    extraConfig = {
      modi = "run,drun,ssh,emoji";
    };

    font = "JuliaMono 14";
    pass = { enable = true; };
    terminal = "foot";
    theme = "gruvbox-dark-soft";

  };
}
