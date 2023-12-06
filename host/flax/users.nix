{
  # TODO: abstract users.users part away
  users.users.kiwi = {
    isNormalUser = true;
    description = "Kye";
    extraGroups = ["networkmanager" "wheel" "video" "docker"];
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
        cad
        kanshi
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
        eza
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
        vscode
      ]
    );

    home.stateVersion = "22.11";
    fonts.fontconfig.enable = true;
    home.packages = with pkgs; [
      filezilla
      imagemagick
      neofetch
      signal-desktop
      tectonic
      (pkgs.texlive.combine {inherit (pkgs.texlive) scheme-full;})
    ];
    #xsession.enable = true;
    #xsession.windowManager.awesome.enable = true;
    #xsession.windowManager.awesome.luaModules = with pkgs.luaPackages; [ fennel ];
    lib.file = {
      mkDotfileSymlink = path:
        config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/${path}";
    };

    home.file = {
      nixos.source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos";
    };

    programs.git.signing.key = "30622A0A";

    services.kanshi.profiles = {
      standalone = {
        outputs = [
          {
            criteria = "eDP-1";
            scale = 1.5;
          }
        ];
      };
    };
  };
}
