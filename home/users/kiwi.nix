{
  # TODO: abstract users.users part away
  users.users.kiwi = {
    isNormalUser = true;
    description = "Kye";
    extraGroups = [ "networkmanager" "wheel" "video" "docker" ];
  };

  home-manager.users.kiwi =
    { pkgs
    , suites
    , config
    , lib
    , ...
    }: {
      imports = suites.base ++ [ ./kiwi/ssh.nix ];
      home.stateVersion = "22.11";
      fonts.fontconfig.enable = true;
      programs.bat.enable = true;
      home.packages = with pkgs; [
        imagemagick
        neofetch
        signal-desktop
        (pkgs.texlive.combine { inherit (pkgs.texlive) scheme-full; })
      ];
      xsession.enable = true;
      xsession.windowManager.awesome.enable = true;
      xsession.windowManager.awesome.luaModules = with pkgs.luaPackages; [ fennel ];
      lib.file = {
        mkDotfileSymlink = path:
          config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/${path}";
      };
      xdg.configFile = {
        awesome.source = config.lib.file.mkDotfileSymlink "flax/awesome";
      };
      home.file = {
        nixos.source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos";
      };
    };
}
