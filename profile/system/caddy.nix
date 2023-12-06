{config, ...}: {
  services = {
    caddy = {
      enable = true;
      virtualHosts = {
        "arky.kshi.xyz" = {
          extraConfig = ''
            respond "hello"
          '';
        };
        "php.kshi.xyz" = {
          extraConfig = ''
            root * /var/www/php
            file_server
            php_fastcgi unix/${config.services.phpfpm.pools."php.kshi.xyz".socket}
          '';
        };
      };
    };

    phpfpm = {
      pools = {
        "php.kshi.xyz" = {
          user = config.services.caddy.user;
          settings = {
            "listen.owner" = config.services.caddy.user;
            pm = "ondemand";
            "pm.max_children" = 16;
          };
        };
      };
    };
  };

  networking.firewall.allowedTCPPorts = [80 443];

  systemd.tmpfiles.settings."98-caddy" = {
    "/var/www/php".d = {
      user = "root";
      group = "wheel";
      mode = "0775";
    };
  };
}
