{ config, ... }: {
  programs.alacritty = {
    enable = true;
  };
  xdg.configFile.alacritty.source = config.lib.file.mkDotfileSymlink "flax/alacritty";
}
