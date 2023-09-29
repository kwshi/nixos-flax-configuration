{
  services.gammastep = {
    enable = true;
    provider = "geoclue2";
    tray = true;
    temperature = {
      day = 3500;
      night = 2500;
    };
  };
}
