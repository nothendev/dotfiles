{ pkgs, lib, ... }:
{
  imports = [ ./omema.hardware.nix ];

  ##colmena
  deployment = {
    targetHost = "omema";
    targetUser = "root";
  };

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/vda";

  ## env
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
  ];

  ## services
  services.lemmy = {
    enable = true;
    nginx.enable = true;
    # server.package = pkgs.lemmy-server-unstable;
    settings = {
      hostname = "rozovyrynok.ru";
      captcha.enabled = false;
    };
    database.createLocally = true;
  };

  services.caddy = {
    enable = false;
    email = "pinksheetsmarket@gmail.com";
    virtualHosts = {
      "kenos.minkystudios.ru" = {
        extraConfig = ''
          reverse_proxy http://localhost:8746
        '';
      };
    };
  };

  systemd.services.kenos-ui = {
    enable = false;
    description = "kenos-ui";
    wantedBy = [ "multi-user.target" ];
    after = [ "network.target" ];
    serviceConfig = {
      Type = "simple";
      Restart = "always";
      RestartSec = 3;
      WorkingDirectory = "/srv/kenos-ui";
      ExecStart = "${pkgs.nodejs}/bin/node dist/ui/server/server.mjs";
      Environment = "PORT=8746";
    };
  };

  # systemd.services.lemmy-ui = {
  #   enable = false;
  #   # i hate rebuilds so do this
  #   serviceConfig.ExecStart = lib.mkForce
  #     "${pkgs.nodejs}/bin/node /srv/lemmy-ui/dist/js/server.js";
  # };

  ## net
  networking = {
    hostName = "omema";
    networkmanager.enable = true;
    nameservers = [
      "1.1.1.1"
      "1.0.0.1"
    ];
    firewall.enable = false;
  };

  ## net::ssh
  services.openssh.enable = true;
  services.openssh.settings.PermitRootLogin = "without-password";
  users.users.root.initialHashedPassword = "";
  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCh42YtU3Zh7HeR3kQIqqkI9jBCMz5fD9mJSFury+K154lXqOW7g1CtKG9BVwuM88i+91dpHkbmoPPPfnhyfSD5VK/lsog8x++68uwpxE7p3hsAg4kgNaDTLnr2QbWLtTFiW8m3+d91O3zsJ/HY6BVwPBcA/uSBakJXUZlKjYDOK98H1lfNAkKt0FoydFZj455/n+DRiHtHOHnCuQqid5Hg9GK2MNMA4LDhNW5Kzndc7kewSjgnuxW+tKcTJkQlKxwUy8BP1Y559dfXC0jNGEK34ohlJWV8ZkrlYCXk6/7JCemjX4Zi8kaOWuyzPZybnbZtCSL/ApO3wfNd6a2R6gvzV8uGJm8jw5y9uE7Qk2U5yN2pUKuPgRqcKo+pHNbpfh2wqAo54pvlOXHESckhRlf93k4t7FmKBAkAUdsFk1SNYUtp+MmdgbETQxq5qQJO8RNCSMKlChs/+M8NKtYkWsyvCMizTDU6IZmyVms7dlIMb1ACKSd4wB43DN4kSl2EDF0bju5+MEqQICzidZhZ/Rvr2pdjWuIw1x4XhmmVDGxf7mN2oZYUkP4aYfTaMNaND8eJUhDHnxWdWsbs87NVERWde/BBRylKtTaMaVqUMI9YrsOLpWHVaRpWX7S/ITCaV0yyW/p1bUvhVl2mzPzrfkLcU37/hv7DhrXY9c93xe8o1Q== Gloryx key"
    # "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDE+vQqHvX0gKg/DTP+70eynbkOhPXhWi2QXD9Q7RUb2ZWyMQOv4gdGzPPJIlBcOOdfl+bYZgU6CgG9yO4rsGCw7ONoMMm28wgrDf9gnwzYFdBOuLc7QtR4/9BAEhNnXu30c8/kwm/ORVoA4dH+uPoeqewORr+L9bic1gtTdyudkiUThZOgwFWVGLT3heh6a/2QjCrD9Gbcr9lTLiHS7VuZEiB0iUlKo0LEe3AQI54nnBA28YIlE8LFZkLnkBROB+el8Bv2TFKPoKVtz0RWF9TrCojjIHESX1CFW87pVXZP++N4mggtXbCQl27UL+hE2D2TAcer0JAa1epNUImG/XnH pinksheetsmarket"
  ];

  system.stateVersion = "24.05";
}
