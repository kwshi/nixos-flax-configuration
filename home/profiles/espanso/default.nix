{
  pkgs,
  espanso-extra,
  ...
}: {
  # TODO: update espanso in nixpkgs to version 2
  home.packages = with pkgs; [xclip libnotify];
  services.espanso = {
    enable = true;
    package = pkgs.espanso-wayland;
    configs.default = {
      search_trigger = "off";
      toggle_key = false;
    };
    matches.base = {
      matches = [
        {
          trigger = ":fulldate";
          replace = "{{date}}";
          vars = [
            {
              name = "date";
              type = "date";
              params = {format = "%F %T (%A)";};
            }
          ];
        }
        {
          trigger = "\\alpha";
          replace = "α";
        }
      ];
    };
  };

  #home.file.".local/share/espanso/packages/espanso-latex".source = "${espanso-extra.espanso-latex}/espanso-latex";
}
