{
  lib,
  config,
  pkgs,
  ...
}:
with lib;
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
  options.services.pterodactyl = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
    nginxVhost = mkOption {
      type = types.str;
      description = mdDoc ''
        The Nginx virtual host on which the panel will run.
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

  config = mkIf cfg.enable {
    services.redis.servers.${cfg.redisName} = {
      enable = true;
      port = 6379;
    };
    services.nginx.virtualHosts."${cfg.nginxVhost}" = {
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
