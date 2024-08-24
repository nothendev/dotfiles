{ pkgs, ... }:
{
  imports = [ ./pinos.hardware.nix ];

  ##colmena
  deployment = {
    targetHost = "pinos";
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
  services.forgejo = {
    enable = true;
    settings.DEFAULT = {
      APP_NAME = "Minky Forgejo";
    };
    settings.ui = {
      THEMES = "catppuccin-latte-rosewater,catppuccin-latte-flamingo,catppuccin-latte-pink,catppuccin-latte-mauve,catppuccin-latte-red,catppuccin-latte-maroon,catppuccin-latte-peach,catppuccin-latte-yellow,catppuccin-latte-green,catppuccin-latte-teal,catppuccin-latte-sky,catppuccin-latte-sapphire,catppuccin-latte-blue,catppuccin-latte-lavender,catppuccin-frappe-rosewater,catppuccin-frappe-flamingo,catppuccin-frappe-pink,catppuccin-frappe-mauve,catppuccin-frappe-red,catppuccin-frappe-maroon,catppuccin-frappe-peach,catppuccin-frappe-yellow,catppuccin-frappe-green,catppuccin-frappe-teal,catppuccin-frappe-sky,catppuccin-frappe-sapphire,catppuccin-frappe-blue,catppuccin-frappe-lavender,catppuccin-macchiato-rosewater,catppuccin-macchiato-flamingo,catppuccin-macchiato-pink,catppuccin-macchiato-mauve,catppuccin-macchiato-red,catppuccin-macchiato-maroon,catppuccin-macchiato-peach,catppuccin-macchiato-yellow,catppuccin-macchiato-green,catppuccin-macchiato-teal,catppuccin-macchiato-sky,catppuccin-macchiato-sapphire,catppuccin-macchiato-blue,catppuccin-macchiato-lavender,catppuccin-mocha-rosewater,catppuccin-mocha-flamingo,catppuccin-mocha-pink,catppuccin-mocha-mauve,catppuccin-mocha-red,catppuccin-mocha-maroon,catppuccin-mocha-peach,catppuccin-mocha-yellow,catppuccin-mocha-green,catppuccin-mocha-teal,catppuccin-mocha-sky,catppuccin-mocha-sapphire,catppuccin-mocha-blue,catppuccin-mocha-lavender,forgejo-dark,forgejo-light,gitea-light,gitea-dark,gitea-auto,forgejo-auto";
    };
    settings."ui.meta" = {
      AUTHOR = "Minky Forgejo";
      DESCRIPTION = "The Minky git server running Forgejo";
    };
    settings.server = {
      ROOT_URL = "https://git.minkystudios.ru";
      DOMAIN = "git.minkystudios.ru";
      HTTP_ADDR = "0.0.0.0";
      HTTP_PORT = 3080;
    };
    settings.service = {
      DISABLE_REGISTRATION = true;
    };
  };

  services.nextcloud = {
    enable = true;
    hostName = "nc.minkystudios.ru";
    config.adminpassFile = "/var/lib/nc-adminpass";
    https = true;
  };

  security.acme.acceptTerms = true;
  security.acme.defaults.email = "kwilnikow@gmail.com";

  services.nginx = {
    enable = true;
    virtualHosts."git.minkystudios.ru" = {
      addSSL = true;
      enableACME = true;
      extraConfig = ''
        client_max_body_size 512M;
      '';
      locations."/".proxyPass = "http://localhost:3080";
    };
    virtualHosts."nc.minkystudios.ru" = {
      addSSL = true;
      enableACME = true;
    };
  };

  ## net
  networking = {
    hostName = "pinos";
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
  ];

  system.stateVersion = "24.05";
}
