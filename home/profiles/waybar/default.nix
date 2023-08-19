{ ks, ... }: {
  programs.waybar = {
    enable = true;
    systemd = { enable = true; };
    settings = import ./settings.nix;

    style =
      let
        none = "none";
        block = { padding = "8px 16px"; };
      in
      ks.toCss {
        "*" = {
          font-family = "'JuliaMono', 'FontAwesome 6 Free'";
          font-size = "20px";
        };

        "window#waybar" = {
          background-color = "transparent";
          color = " #ebdbb2";
        };

        "#clock" = block // { background-color = "#076678"; };

        "#battery" = block // { background-color = "#9d0006"; };
        "#pulseaudio" = block // { background-color = "#af3a03"; };
        "#backlight" = block // { background-color = "#b57614"; };
        "#network" = block // { background-color = "#79740e"; };

        "#tags" = {
          button = {
            background-color = "#32302f";
            border-radius = "0";
            border = "none";
            box-shadow = "none";
            transition = "none";
            font-weight = "bold";
            min-width = "0";
            padding = "4px 16px";
            color = "#fbf1c7";
          };
          "button.occupied:not(.focused)" = {
            background-color = "#8f3f71";
          };
          "button.focused" = {
            background-color = "#d3869b";
            color = "#1d2021";
          };
          "button.urgent" = {
            background-color = "#fb4934";
          };
          "button:hover" = {
            outline = "none";
            box-shadow = "none";
            text-shadow = "none";
            background-image = "none";
          };

        };
      };

    #''
    #    * {
    #        font-family: 'JuliaMono', 'Font Awesome 6 Free';
    #        font-size: 21px;
    #    }
    #  
    #    window#waybar {
    #        background-color: #282828;
    #        color: #ebdbb2;
    #    }

    #    #clock, #pulseaudio, #network {
    #    padding: 8px 16px;
    #    }

    #  
    #  #tags button {
    #    background-color: #32302f;
    #    border-radius: 0;
    #  }
    #  #tags button.occupied {
    #    background-color: #79740e;
    #  }
    #  #tags button.focused {
    #    background-color: #b8bb26;
    #  }
    #  #tags button.urgent {
    #    background-color: #fb4934;
    #  }

    #  #tags button:hover {
    #    outline: none;
    #    box-shadow: none;
    #    text-shadow: none;
    #    background: none;
    #    transition: none;
    #  }

    #'';
  };
}
