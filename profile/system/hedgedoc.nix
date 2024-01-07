let
  # socketPath = "/run/hedgedoc/hedgedoc.sock";
  port = 9231;
in {
  # for now, nixpkgs has hedgedoc v1, which doesn't have working unix socket permissions:
  # <https://github.com/hedgedoc/hedgedoc/issues/624>

  # when nixpkgs gets hedgedoc v2, update!
  services = {
    hedgedoc = {
      enable = true;
      settings = {
        #path = socketPath;
        inherit port;
        host = "localhost";
        domain = "doc.kshi.xyz";
        protocolUseSSL = true;
      };
    };

    caddy.virtualHosts."doc.kshi.xyz".extraConfig = ''
      reverse_proxy localhost:${toString port}
    '';
    # reverse_proxy unix/${socketPath}
  };
}
