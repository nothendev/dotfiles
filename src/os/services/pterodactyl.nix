{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.services.pterodactyl;
  pterodactlyPhp81 = (
    pkgs.php81.buildEnv {
      extensions =
        { enabled, all }:
        enabled
        ++ (with all; [
          redis
          xdebug
        ]);
      extraConfig = ''
        xdebug.mode=debug
      '';
    }
  );
in
{
  options.services.pterodactyl = with lib; {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
    hostName = mkOption {
      type = types.str;
      description = mdDoc ''
        The hostname on which the panel will run.
      '';
      default = "localhost";
      example = literalExpression "mgr.matestmc.net";
    };
    user = mkOption {
      type = types.str;
      description = mdDoc ''
        The user that Nginx and the panel will run with.
      '';
      default = "pterodactyl";
      example = literalExpression "pterodactyl";
    };
    dataDir = mkOption {
      type = types.str;
      description = mdDoc ''
        The directory with the panel files.
        Usually /srv/pterodactyl or /var/www/pterodactyl.
      '';
      default = "/srv/pterodactyl";
      example = literalExpression "/srv/pterodactyl";
    };
    redisName = mkOption {
      type = types.str;
      description = mdDoc ''
        The Redis server name.
      '';
      default = "pterodactis";
    };
  };

  config = lib.mkIf cfg.enable {
    services.redis.servers.${cfg.redisName} = {
      enable = true;
      port = 6379;
    };
    services.nginx.virtualHosts."${cfg.hostName}" = {
      addSSL = true;
      #forceSSL = true;
      enableACME = true;
      root = "${cfg.dataDir}/public";
      extraConfig = ''
        index index.html index.htm index.php;
      '';
      locations = {
        "~ \\.php$" = {
          extraConfig = ''
            fastcgi_split_path_info ^(.+\.php)(/.+)$;
            fastcgi_pass unix:${config.services.phpfpm.pools.pterodactyl.socket};
            include ${pkgs.nginx}/conf/fastcgi_params;
            fastcgi_index index.php;
            fastcgi_param PHP_VALUE "upload_max_filesize = 100M \n post_max_size=100M";
            fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
            fastcgi_param HTTP_PROXY "";
            fastcgi_intercept_errors off;
            fastcgi_buffer_size 16k;
            fastcgi_buffers 4 16k;
            fastcgi_connect_timeout 300;
            fastcgi_send_timeout 300;
            fastcgi_read_timeout 300;
          '';
        };
        "/" = {
          tryFiles = "$uri $uri/ /index.php?$query_string";
        };
      };
    };
    services.phpfpm.pools.pterodactyl = {
      user = cfg.user;
      settings = {
        "listen.owner" = config.services.nginx.user;
        "pm" = "dynamic";
        "pm.start_servers" = 4;
        "pm.min_spare_servers" = 4;
        "pm.max_spare_servers" = 16;
        "pm.max_children" = 64;
        "pm.max_requests" = 256;

        "clear_env" = false;
        "catch_workers_output" = true;
        "decorate_workers_output" = false;
        "php_admin_value[error_log]" = "stderr";
        "php_admin_flag[daemonize]" = "false";
      };
    };
    services.caddy.globalConfig = ''
    servers :443 {
      timeouts {
        read_body 120s
      }
    }
    '';
    services.caddy.virtualHosts.${cfg.hostName} = {
      extraConfig = ''
        root * ${cfg.dataDir}/public
        file_server
        php_fastcgi unix/${config.services.phpfpm.pools.pterodactyl.socket} {
          root ${cfg.dataDir}/public
          index index.php
          env PHP_VALUE "upload_max_filesize = 100M
          post_max_size=100M"
          env HTTP_PROXY ""
          env HTTPS "on"

          read_timeout 300s
          dial_timeout 300s
          write_timeout 300s
        }

        header Strict-Transport-Security "max-age=16768000; preload;"
        header X-Content-Type-Options "nosniff"
        header X-XSS-Protection "1; mode=block;"
        header X-Robots-Tag "none"
        header Content-Security-Policy "frame-ancestors 'self'"
        header X-Frame-Options "DENY"
        header Referrer-Policy "same-origin"

        request_body {
            max_size 100m
        }

        respond /.ht* 403

        log {
            output file /var/log/caddy/pterodactyl.log {
                roll_size 100MiB
                roll_keep_for 7d
            }
            level INFO
        }
      '';
    };
    users.users.${cfg.user} = {
      isSystemUser = true;
      createHome = true;
      home = cfg.dataDir;
      group = cfg.user;
      extraGroups = [ "acme" ];
    };
    users.groups.${cfg.user} = { };

    systemd.services.pteroq = {
      enable = true;
      description = "Pterodactyl queue worker";
      after = [ "redis-${cfg.redisName}.service" ];
      unitConfig = {
        StartLimitInterval = 180;
      };
      serviceConfig = {
        User = cfg.user;
        Group = cfg.user;
        Restart = "always";
        ExecStart = "${pterodactlyPhp81}/bin/php ${cfg.dataDir}/artisan queue:work --queue=high,standard,low --sleep=3 --tries=3";
        StartLimitBurst = 30;
        RestartSec = "5s";
      };
      wantedBy = [ "multi-user.target" ];
    };

    environment.systemPackages = [
      # php 8.1 with the needed exts
      pterodactlyPhp81
      # composer
      (pkgs.php81Packages.composer.override { php = pterodactlyPhp81; })
    ];
  };
}
