{ config, pkgs, ... }: {
  imports = [
    ./binkus.hardware.nix
    ../os/services/pterodactyl.nix
    ../os/services/wings.nix
  ];

  deployment = {
    tags = [ "matest" "mh-dedic" "masterhost" ];
    targetHost = "87.242.74.225";
    targetUser = "root";
  };
  security.acme = {
    acceptTerms = true;
    defaults.email = "god@matestmc.ru";
  };

  users.defaultUserShell = pkgs.fish;
  programs.fish.enable = true;
  environment.shells = with pkgs; [ bash fish ];

  environment.systemPackages = with pkgs; [ neovim wget curl fish git ];

  services.nginx.virtualHosts."acme.matestmc.ru" = {
    serverAliases = [ "*.matestmc.ru" ];
    locations."/.well-known/acme-challenge" = {
      root = "/var/lib/acme/.challenges";
    };
    locations."/" = { return = "301 https://$host$request_uri"; };
  };

  system.stateVersion = "24.05";
  services.openssh.enable = true;
  services.openssh.settings = { PermitRootLogin = "yes"; };

  services.mysql = {
    enable = true;
    package = pkgs.mariadb;
  };
  services.nginx.enable = true;
  services.nginx.user = "pterodactyl";

  networking = {
    hostName = "binkus";
    networkmanager.enable = true;
    nameservers = [ "1.1.1.1" "1.0.0.1" ];
    firewall.enable = false;
  };

  # Set your time zone.
  time.timeZone = "Europe/Moscow";

  i18n.defaultLocale = "en_US.UTF-8";
  users.users.root.initialHashedPassword = "";

  # pterodactyl
  services.pterodactyl = {
    enable = true;
    nginxVhost = "mgr.matestmc.ru";
    user = "pterodactyl";
    dataDir = "/srv/pterodactyl";
    redisName = "pterodactis";
  };

  # wings
  services.wings = {
    enable = true;
    package = pkgs.callPackage ../pkgs/wings.nix { };
  };

  virtualisation.oci-containers.backend = "docker";
}
