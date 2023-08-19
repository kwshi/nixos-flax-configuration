{ pkgs, ... }: {
  services.printing = {
    enable = true;
    drivers = with pkgs; [ canon-cups-ufr2 ];
  };
  services.system-config-printer.enable = true;
  programs.system-config-printer.enable = true;
}
