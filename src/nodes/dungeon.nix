{ pkgs, self, system, ... }:
{
  imports = [
    ./dungeon.hardware.nix
    ../os/services/mattermost.nix
    ../os/services/pterodactyl.nix
    ../os/services/wings.nix
  ];

  deployment = {
    targetHost = "dungeon";
    targetUser = "root";
  };

  nix.settings.sandbox = false;

  security.acme = {
    acceptTerms = true;
    defaults.email = "kwilnikow@gmail.com";
    certs."binkus.minkystudios.ru" = {
      dnsProvider = "cloudflare";
      environmentFile = "/var/lib/trfk/env";
    };
    defaults.group = "pterodactyl";
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
  ];

  services.nginx = {
    enable = false;
    user = "pterodactyl";
    virtualHosts = {
      "acme.minkystudios.ru" = {
        serverAliases = [ "*.minkystudios.ru" ];
        locations."/.well-known/acme-challenge" = {
          root = "/var/lib/acme/.challenges";
        };
        locations."/" = {
          return = "301 https://$host$request_uri";
        };
      };

      "binkus.minkystudios.ru" = {
        enableACME = true;
      };

      "kys.minkystudios.ru" = {
        enableACME = true;
        locations."/" = {
          proxyPass = "https://localhost:6443";
        };
      };

      #"mm.minkystudios.ru" = {
      #  enableACME = true;
      #  # proxy_pass to localhost:8065
      #  locations."/" = {
      #    proxyPass = "http://localhost:8065";
      #  };
      #};
    };
  };

  services.caddy = {
    enable = true;
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
      "kys.minkystudios.ru" = {
        extraConfig = ''
          reverse_proxy https://localhost:6443
        '';
      };
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
    AmbientCapabilities = ["CAP_NET_BIND_SERVICE" "CAP_NET_RAW" "CAP_NET_ADMIN" "CAP_SYS_RESOURCE"];
    CapabilityBoundingSet = ["CAP_NET_BIND_SERVICE" "CAP_NET_RAW" "CAP_NET_ADMIN" "CAP_SYS_RESOURCE"];
    PrivateTmp = true;
    ProtectSystem = "full";
    TimeoutStopSec = "5s";
  };

  system.stateVersion = "24.05";
  services.openssh.enable = true;
  services.openssh.settings = {
    PermitRootLogin = "without-password";
  };

  services.mysql = {
    enable = true;
    package = pkgs.mariadb;
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
  services.pterodactyl = {
    enable = true;
    hostName = "mgr.minkystudios.ru";
    user = "pterodactyl";
    dataDir = "/srv/pterodactyl";
    redisName = "pterodactis";
  };

  # wings
  services.wings = {
    enable = true;
    package = pkgs.callPackage ../pkgs/wings.nix { };
  };

  systemd.services.wings = {
    after = [ "acme-binkus.minkystudios.ru.service" ];
    requires = [ "acme-binkus.minkystudios.ru.service" ];
  };

  #kys
  services.traefik = {
    enable = false;
    staticConfigOptions = {
      entryPoints = {
        web.address = ":80";
        websecure.address = ":443";
        minecraft.address = ":25565";
        traefik.address = ":6942";
      };
      api.dashboard = true;
      providers.kubernetesCRD.endpoint = "https://localhost:6443";
      providers.kubernetesCRD.token = "\${TRFK_TOKEN}";
      providers.kubernetesCRD.certAuthFilePath = "/var/lib/trfk/ca.crt";
      providers.kubernetesIngress.endpoint = "https://localhost:6443";
      providers.kubernetesIngress.token = "\${TRFK_TOKEN}";
      providers.kubernetesIngress.certAuthFilePath = "/var/lib/trfk/ca.crt";
      certificatesResolvers.letsenc.acme = {
        storage = "/var/lib/traefik/acme.json";
        dnsChallenge.provider = "cloudflare";
        dnsChallenge.resolvers = [
          "1.1.1.1"
          "1.0.0.1"
        ];
      };
      log.level = "DEBUG";
    };
    environmentFiles = [ "/var/lib/trfk/env" ];
    dynamicConfigFile = "/var/lib/trfk/dynamic.yaml";
  };
  services.k3s = {
    enable = true;
    role = "server";
    extraFlags = "--disable traefik --service-node-port-range 25565-32767";
  };

  virtualisation.oci-containers.backend = "docker";
}
