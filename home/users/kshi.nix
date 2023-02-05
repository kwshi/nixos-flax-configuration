{
  # TODO: abstract users.users part away
  users.users.kshi = {
    isNormalUser = true;
    description = "Kye";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  home-manager.users.kshi =
    { pkgs
    , suites
    , config
    , lib
    , ...
    }: {
      #programs.texlive.enable = true;
      #programs.texlive.packageSet = pkgs.texlive.combined.scheme-full;
      imports = suites.base ++ [ ./kshi/ssh.nix ];
      home.stateVersion = "22.11";
      fonts.fontconfig.enable = true;
      programs.bat.enable = true;
      home.packages = with pkgs; [
        neofetch
        julia-mono
        signal-desktop
        (pkgs.texlive.combine { inherit (pkgs.texlive) scheme-full; })
      ];
      programs.firefox.enable = true;
      programs.git.enable = true;
      programs.git.userName = "Kye Shi";
      programs.alacritty.enable = true;
      programs.password-store = {
        enable = true;
      };
      programs.gpg = {
        enable = true;
      };
      services.gpg-agent = {
        enable = true;
      };
      programs.git.userEmail = "shi.kye@gmail.com";
      xsession.enable = true;
      xsession.windowManager.awesome.enable = true;
      xsession.windowManager.awesome.luaModules = with pkgs.luaPackages; [ fennel ];
      xdg.configFile = {
        awesome.source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/flax/awesome";
        alacritty.source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/flax/alacritty";
        nvim.source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/flax/neovim";
      };
      home.file = {
        nixos.source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos";
      };
    };
}
