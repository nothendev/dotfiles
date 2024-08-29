{
  pkgs,
  self,
  system,
  ...
}:
{
  imports = [
    ./dungeon.hardware.nix
    #../os/services/pterodactyl.nix
    #../os/services/wings.nix
  ];

  deployment = {
    targetHost = "dungeon";
    targetUser = "root";
  };

  nix.settings.sandbox = false;

  security.acme = {
    acceptTerms = true;
    defaults.email = "kwilnikow@gmail.com";
    #certs."binkus.minkystudios.ru" = {
    #  dnsProvider = "cloudflare";
    #  environmentFile = "/var/lib/trfk/env";
    #};
    #defaults.group = "pterodactyl";
  };

  users.defaultUserShell = pkgs.fish;
  programs.fish.enable = true;
  environment.shells = with pkgs; [
    bash
    fish
  ];
  environment.systemPackages = with pkgs; [
    neovim
    wget
    curl
    fish
    git
    btop

    kubectl
    kubernetes
    kubernetes-helm
    linkerd_edge
  ];

  services.caddy = {
    enable = false;
    package = self.packages.${system}.customCaddyBuiltWithFuckingGatewayAndShit;
    email = "kwilnikow@gmail.com";
    user = "pterodactyl";
    group = "pterodactyl";
    enableReload = true;
    globalConfig = ''
      admin localhost:2019
      acme_dns cloudflare {env.CF_API_TOKEN}
    '';
    virtualHosts = {
      "mgr.minkystudios.ru".extraConfig = ''
        tls {
          dns cloudflare {env.CF_API_TOKEN}
        }
      '';
      "mm.minkystudios.ru" = {
        extraConfig = ''
          reverse_proxy http://localhost:8065
        '';
      };
    };
  };
  systemd.services.caddy.serviceConfig = {
    EnvironmentFile = "/var/lib/trfk/env";
    AmbientCapabilities = [
      "CAP_NET_BIND_SERVICE"
      "CAP_NET_RAW"
      "CAP_NET_ADMIN"
      "CAP_SYS_RESOURCE"
    ];
    CapabilityBoundingSet = [
      "CAP_NET_BIND_SERVICE"
      "CAP_NET_RAW"
      "CAP_NET_ADMIN"
      "CAP_SYS_RESOURCE"
    ];
    PrivateTmp = true;
    ProtectSystem = "full";
    TimeoutStopSec = "5s";
  };

  system.stateVersion = "24.05";
  services.openssh.enable = true;
  services.openssh.settings = {
    PermitRootLogin = "without-password";
  };

  networking = {
    hostName = "dungeon";
    networkmanager.enable = true;
    nameservers = [
      "1.1.1.1"
      "1.0.0.1"
    ];
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
  #services.pterodactyl = {
  #  enable = true;
  #  hostName = "mgr.minkystudios.ru";
  #  user = "pterodactyl";
  #  dataDir = "/srv/pterodactyl";
  #  redisName = "pterodactis";
  #};

  # wings
  #services.wings = {
  #  enable = true;
  #  package = pkgs.callPackage ../pkgs/wings.nix { };
  #};

  #systemd.services.wings = {
  #  after = [ "acme-binkus.minkystudios.ru.service" ];
  #  requires = [ "acme-binkus.minkystudios.ru.service" ];
  #};

  services.haproxy = {
    enable = false;
    config = ''
      global
        log stderr format iso local7
      defaults
        log global
      frontend http
      	bind :80
      	option tcplog
      	mode tcp
      	default_backend emissary-http
      frontend https
      	bind :443
      	option tcplog
      	mode tcp
      	default_backend emissary-https
      frontend minecraft
      	bind :25565
      	option tcplog
      	mode tcp
      	default_backend emissary-minecraft

      backend emissary-http
      	mode tcp
      	server self 127.0.0.1:8080
      backend emissary-https
      	mode tcp
      	server self 127.0.0.1:8443
      backend emissary-minecraft
        mode tcp
      	server self 127.0.0.1:8665
    '';
  };

  services.k3s = {
    enable = true;
    role = "server";
    extraFlags = "--disable traefik --tls-san 95.165.149.100";
  };

  virtualisation.oci-containers.backend = "docker";
}
