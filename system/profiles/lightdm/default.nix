{
  services.xserver = {
    enable = true;
    layout = "us";
    xkbVariant = "workman";
    xkbOptions = "ctrl:nocaps,altwin:swap_alt_win";
    libinput = {
      enable = true;
      touchpad.accelProfile = "flat";
      mouse.accelProfile = "flat";
    };

    displayManager = {
      defaultSession = "none+xsession";
      session = [
        {
          name = "xsession";
          manage = "window";
          start = "";
        }
      ];
      lightdm = {
        enable = false;
        greeters.mini = {
          user = "kiwi";
          enable = true;
          extraConfig = ''
            [greeter]
            show-password-label = false
            password-input-width = 48
            password-alignment = "right"

            [greeter-theme]
            font = "JuliaMono"
            background-image = ""
            background-color = "#32302f"
            password-border-radius = 0px
            window-color = "#689d6a"
            layout-space = 4
            border-width = 0px
          '';
        };
      };
    };
  };
}
