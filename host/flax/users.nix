{
  # TODO: abstract users.users part away
  users.users.kiwi = {
    isNormalUser = true;
    description = "Kye";
    extraGroups = ["networkmanager" "wheel" "video"];
  };

  home-manager.users.kiwi = {
    pkgs,
    profiles,
    config,
    lib,
    ...
  }: {
    imports = (
      with profiles; [
        ssh
        sagemath
        eww
        misc
        bat
        neovim
        rofi
        python
        github
        zathura
        firefox
        git
        pass
        btop
        alacritty
        starship
        user-dirs
        gammastep
        espanso
        bash
        exa
        thunderbird
        fonts
        gpg
        ime
        mpv
        jq
        octave
        xournalpp
        java
        theme
        mathematica
        udiskie
        waybar
        foot
        river
        qtile
        rust
        safeeyes
        haskell
      ]
    );

    home.stateVersion = "22.11";
    fonts.fontconfig.enable = true;
    programs.bat.enable = true;
    home.packages = with pkgs; [
      imagemagick
      neofetch
      signal-desktop
      (pkgs.texlive.combine {inherit (pkgs.texlive) scheme-full;})
    ];
    xsession.enable = true;
    xsession.windowManager.awesome.enable = true;
    xsession.windowManager.awesome.luaModules = with pkgs.luaPackages; [fennel];
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
