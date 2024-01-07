let
  port = 5823;
in {
  services = {
    whitebophir = {
      enable = true;
      inherit port;
      listenAddress = "localhost";
    };
    caddy.virtualHosts."board.kshi.xyz".extraConfig = ''
      reverse_proxy localhost:${toString port}
    '';
  };
}
