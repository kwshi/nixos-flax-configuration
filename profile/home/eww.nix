{
  pkgs,
  config,
  ...
}: {
  programs.eww = {
    enable = true;
    package = pkgs.eww-wayland;
    configDir = config.lib.file.mkDotfileSymlink "flax/.config/eww";
  };
}
