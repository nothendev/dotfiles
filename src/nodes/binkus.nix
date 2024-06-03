{ config, pkgs, ... }: {
  imports = [
    ./binkus.hardware.nix
    ../os/services/pterodactyl.nix
    ../os/services/wings.nix
  ];

  deployment = {
    tags = [ "minkyst" "ehost" ];
    targetHost = "dungeon";
    targetUser = "root";
  };
  security.acme = {
    acceptTerms = true;
    defaults.email = "god@matestmc.ru";
  };

  users.defaultUserShell = pkgs.fish;
  programs.fish.enable = true;
  environment.shells = with pkgs; [ bash fish ];
  environment.systemPackages = with pkgs; [ neovim wget curl fish git btop ];

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
    enable = false;
    package = pkgs.mariadb;
  };
  services.nginx.enable = true;
  services.nginx.user = "pterodactyl";

  networking = {
    hostName = "dungeon";
    networkmanager.enable = true;
    nameservers = [ "1.1.1.1" "1.0.0.1" ];
    firewall.enable = false;
  };

  # Set your time zone.
  time.timeZone = "Europe/Moscow";

  i18n.defaultLocale = "en_US.UTF-8";
  users.users.root.initialHashedPassword = "";
  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCh42YtU3Zh7HeR3kQIqqkI9jBCMz5fD9mJSFury+K154lXqOW7g1CtKG9BVwuM88i+91dpHkbmoPPPfnhyfSD5VK/lsog8x++68uwpxE7p3hsAg4kgNaDTLnr2QbWLtTFiW8m3+d91O3zsJ/HY6BVwPBcA/uSBakJXUZlKjYDOK98H1lfNAkKt0FoydFZj455/n+DRiHtHOHnCuQqid5Hg9GK2MNMA4LDhNW5Kzndc7kewSjgnuxW+tKcTJkQlKxwUy8BP1Y559dfXC0jNGEK34ohlJWV8ZkrlYCXk6/7JCemjX4Zi8kaOWuyzPZybnbZtCSL/ApO3wfNd6a2R6gvzV8uGJm8jw5y9uE7Qk2U5yN2pUKuPgRqcKo+pHNbpfh2wqAo54pvlOXHESckhRlf93k4t7FmKBAkAUdsFk1SNYUtp+MmdgbETQxq5qQJO8RNCSMKlChs/+M8NKtYkWsyvCMizTDU6IZmyVms7dlIMb1ACKSd4wB43DN4kSl2EDF0bju5+MEqQICzidZhZ/Rvr2pdjWuIw1x4XhmmVDGxf7mN2oZYUkP4aYfTaMNaND8eJUhDHnxWdWsbs87NVERWde/BBRylKtTaMaVqUMI9YrsOLpWHVaRpWX7S/ITCaV0yyW/p1bUvhVl2mzPzrfkLcU37/hv7DhrXY9c93xe8o1Q== Gloryx key"
  ];

  # pterodactyl
  services.pterodactyl = {
    enable = false;
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
