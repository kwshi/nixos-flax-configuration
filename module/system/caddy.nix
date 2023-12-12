{
  lib,
  config,
  ...
}: let
  caddyCfg = config.services.caddy;
in {
  options.ks.caddy = {
    enable = lib.mkEnableOption "Caddy web server";

    host = lib.mkOption {
      type = lib.types.attrsOf (lib.types.submodule ({
        name,
        config,
        ...
      }: {
        options = {
          path = lib.mkOption {
            type = lib.types.str;
            default = "/var/www/${name}";
          };
          php = {
            enable = lib.mkEnableOption "Caddy virtual host with PHP-FPM";
          };
          user = lib.mkOption {
            type = lib.types.str;
            default = caddyCfg.user;
          };
          group = lib.mkOption {
            type = lib.types.str;
            default = config.user;
          };
        };
      }));
    };
  };

  config = let
    cfg = config.ks.caddy;
  in
    lib.mkIf cfg.enable {
      users = {
        users = lib.attrsets.concatMapAttrs (name: host:
          if host.user == config.services.caddy.user
          then {}
          else {
            ${host.user} = {
              isSystemUser = true;
              group = host.group;
            };
          })
        cfg.host;

        groups = lib.attrsets.concatMapAttrs (name: host:
          if host.group == config.services.caddy.group
          then {}
          else {${host.group} = {};})
        cfg.host;
      };

      services = {
        caddy = {
          enable = true;
          virtualHosts =
            lib.attrsets.mapAttrs (name: host: {
              logFormat = ''
                output file ${config.services.caddy.logDir}/access-${name}.log
              '';
              extraConfig = ''
                root * ${host.path}
                file_server
                ${lib.strings.optionalString
                  host.php.enable
                  "php_fastcgi unix/${config.services.phpfpm.pools.${name}.socket}"}
              '';
            })
            cfg.host;
        };

        phpfpm = {
          pools =
            lib.attrsets.mapAttrs (name: host: {
              user = host.user;
              group = host.group;
              settings = {
                "listen.owner" = config.services.caddy.user;
                pm = "ondemand";
                "pm.max_children" = 16;
              };
              phpOptions = ''
                display_errors = on;
              '';
            })
            cfg.host;
        };
      };

      networking.firewall.allowedTCPPorts = [80 443];

      systemd.tmpfiles.settings."98-caddy" =
        lib.attrsets.mapAttrs'
        (
          name: host:
            lib.attrsets.nameValuePair (host.path) {
              d = {
                user = host.user;
                group = host.group;
                mode = "2775";
                # setgid bit causes new entries in folder to inherit associated group
              };
            }
        )
        cfg.host;
    };
}
