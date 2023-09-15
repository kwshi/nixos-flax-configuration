{
  users.users.kiwi = {
    isNormalUser = true;
    home = "/home/kiwi";
    extraGroups = ["wheel"];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFyQ55TUP8Z6WWWvun4v7jD167Lx9yuLqUCO124kRFEY kiwi@flax"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBV9Y65uxFw68NvGELnZ8blYts+TPLB+f+oqH01RNN49 kshi@boi"
    ];
  };

  home-manager.users.kiwi = {
    pkgs,
    profiles,
    config,
    lib,
    ...
  }: {
    imports = [
      profiles.helix
      profiles.neovim-nix
      profiles.bash
      profiles.bat
      profiles.btop
      profiles.exa
      profiles.git
      profiles.github
      profiles.gpg
      profiles.user-dirs
      profiles.starship
      profiles.pass
    ];
    home.stateVersion = "23.05";
    programs.git.signing.key = "D1AF94B0";
    services.gpg-agent.pinentryFlavor = "curses";
  };
}
