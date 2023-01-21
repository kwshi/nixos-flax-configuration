{hmUsers, ...}: {
  # TODO: abstract users.users part away
  users.users.kshi = {
    isNormalUser = true;
    description = "Kye";
    extraGroups = ["networkmanager" "wheel"];
    #    packages = with pkgs; [];
  };

  home-manager.users.kshi = hmUsers.kshi;
}
