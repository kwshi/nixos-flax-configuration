{ config, ... }: {
  programs.eww = {
    enable = true;
    configDir = config.lib.file.mkDotfileSymlink "flax/.config/eww";
  };
}
