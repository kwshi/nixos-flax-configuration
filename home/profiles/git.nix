{
  programs.git = {
    enable = true;
    userName = "Kye Shi";
    userEmail = "kiwishi@pm.me";
    signing = {
      key = "69B1A859";
      signByDefault = true;
    };
    extraConfig = {
      core = {
        editor = "nvim";
      };
    };
    delta = {
      enable = true;
      options = {side-by-side = true;};
    };
  };
}
