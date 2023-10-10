{
  programs.foot = {
    enable = true;
    settings = {
      main = {
        font = "JuliaMono:size=12";
        dpi-aware = "no";
      };
      colors = {
        alpha = 1.0;
        background = "1d2021";
        foreground = "ebdbb2";

        ## Normal/regular colors (color palette 0-7)
        regular0 = "282828"; # black
        regular1 = "cc241d"; # red
        regular2 = "98971a"; # green
        regular3 = "d79921"; # yellow
        regular4 = "458588"; # blue
        regular5 = "b16286"; # magenta
        regular6 = "689d6a"; # cyan
        regular7 = "a89984"; # white

        ## Bright colors (color palette 8-15)
        bright0 = "32302f"; # bright black
        bright1 = "fb4934"; # bright red
        bright2 = "b8bb26"; # bright green
        bright3 = "fabd2f"; # bright yellow
        bright4 = "83a598"; # bright blue
        bright5 = "d3869b"; # bright magenta
        bright6 = "8ec07c"; # bright cyan
        bright7 = "ebdbb2"; # bright white

        ## dimmed colors (see foot.ini(5) man page)
        # dim0=<not set>
        # ...
        # dim7=<not-set>
      };
    };
  };
}
