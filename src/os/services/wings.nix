{
  lib,
  config,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.services.wings;
in
{
  options.services.wings = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
    package = mkOption { type = types.package; };
  };

  config = mkIf cfg.enable {
    virtualisation.docker.enable = true;
    systemd.services.wings = {
      enable = cfg.enable;
      description = "Pterodactyl Wings daemon";
      after = [ "docker.service" ];
      partOf = [ "docker.service" ];
      requires = [ "docker.service" ];
      startLimitIntervalSec = 180;
      startLimitBurst = 30;
      serviceConfig = {
        User = "root";
        RuntimeDirectory = "wings";
        LimitNOFILE = 4096;
        PIDFile = "/var/run/wings/daemon.pid";
        ExecStart = "${cfg.package}/bin/wings --config /var/lib/wings.yml";
        Restart = "on-failure";
        RestartSec = "5s";
      };
      wantedBy = [ "multi-user.target" ];
    };
  };
}
