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
    imports = with profiles; [
      git
      ssh
      bash
      bat
      btop
      eza
      fonts
      foot
      user-dirs
      waybar
      neovim #neovim-nix
      theme
      firefox
      gpg
      starship
      rofi
      helix
      mpv
      zathura
      github
      hyprland
      gammastep
      ime
    ];
    programs.git.signing.key = "3B1646CD";
    home.packages = with pkgs; [just];
    home.stateVersion = "23.05";
    home.file = {
      nixos.source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos";
    };
  };
}
# ../profiles/alacritty.nix ../profiles/bash.nix ../profiles/bat.nix ../profiles/btop.nix ../profiles/espanso ../profiles/eww.nix ../profiles/exa.nix ../profiles/firefox.nix ../profiles/fonts.nix ../profiles/foot.nix ../profiles/gammastep.nix ../profiles/github.nix ../profiles/git.nix ../profiles/gpg.nix ../profiles/haskell.nix ../profiles/ime.nix ../profiles/java.nix ../profiles/jq.nix ../profiles/mathematica.nix ../profiles/misc.nix ../profiles/mpv.nix ../profiles/neovim ../profiles/octave.nix ../profiles/pass.nix ../profiles/python.nix ../profiles/qtile.nix ../profiles/river.nix ../profiles/rofi ../profiles/rust.nix ../profiles/safeeyes.nix ../profiles/sagemath.nix ../profiles/starship.nix ../profiles/theme.nix ../profiles/thunderbird.nix ../profiles/udiskie.nix ../profiles/user-dirs.nix ../profiles/waybar ../profiles/xournalpp ../profiles/zathura.nix

