{
  top = {
    name = "top";
    layer = "top";
    position = "top";

    modules-left = ["river/tags"];
    modules-right = ["clock"];

    "river/tags" = {
      num-tags = 5;
    };

    clock = {
      interval = "1";
      format = " {:%F %T (%A) %Z}";
    };
  };

  bottom = {
    name = "bottom";
    layer = "top";
    position = "bottom";

    modules-left = ["battery" "pulseaudio" "backlight" "network"];
    modules-right = ["tray"];

    network = {
      format-wifi = " {signalStrength}% ({ipaddr} @ {essid})";
    };

    backlight = {
      #device= "intel_backlight";
      format = "{icon} {percent}%";
      format-icons = ["" ""];
    };

    pulseaudio = {
      format = "{icon} {volume}%";
      format-muted = " {volume}%";
      format-icons = {
        headphone = "";
        hands-free = "";
        headset = "";
        phone = "";
        portable = "";
        car = "";
        default = ["" ""];
      };
      on-click = "pavucontrol";
    };

    battery = {
      interval = 60;
      format = "{icon} {capacity}%";
      format-icons = ["" "" "" "" ""];
    };

    tray = {
      icon-size = 32;
      spacing = 10;
    };
  };
}
