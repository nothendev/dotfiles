{ pkgs, ... }: {
  imports = [
    ./minky.hardware.nix
    # ../os/services/mattermost.nix
    ../os/services/agh.nix
  ];
  deployment = {
    tags = [ "home" ];
    targetHost = "192.168.23.46";
    targetUser = "root";
  };
  programs.fish.enable = true;
  environment.shells = with pkgs; [ bash fish ];
  users.defaultUserShell = pkgs.fish;
  nix.extraOptions = ''
    keep-outputs = true
    experimental-features = nix-command flakes
  '';

  environment.systemPackages = with pkgs; [
    neovim
    wget
    curl
    fish
    git
    bat
    btop
    mercurial
    forgejo
  ];

  services.cloudflared = {
    enable = true;
    tunnels."b962a0e8-d103-4275-a301-4b40208de026" = {
      credentialsFile =
        "/var/lib/cloudflared/b962a0e8-d103-4275-a301-4b40208de026.json";
      ingress."git.matestmc.ru".service = "http://localhost:3080";
      default = "http_status:404";
    };
  };

  networking = {
    hostName = "minky";
    networkmanager.enable = true;
    wireless.iwd.enable = true;
    networkmanager.wifi.backend = "iwd";
  };
  time.timeZone = "Europe/Moscow";
  i18n.defaultLocale = "en_US.UTF-8";
  system.stateVersion = "24.05";
  services.openssh.enable = true;
  services.openssh.settings = { PermitRootLogin = "yes"; };
  users.groups.git = {};
  users.users.git = {
    group = "git";
    isNormalUser = true;
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCnAcAQiO4tTvlpIu4PN2uWjDKr4/vOKkgFjb8UN4K74BO9Goa1nSqiiPaTGMUF0QZkeXo7KRJLyfUHt8HV/8udeVCaFywlzdje56MDkud1RFAAPa7FNFnYs62IbO2eGpODxnm7c/wRZJ4BEhL/RwBG85Rsb6CmB7/eWbrjUCJfUlG6Qta8V7mvPplXvV91dyoqymH5H/PXxGAMD/xOWOm4RjZFcj+o1mI8K2ilo/cDDQ+ZTyk0/vjkFBXlbURJA4xLp+rL2Fteo4LwMV6prHTOGoihYUeRYcRVJsNMQoTslyOsE+Q22yEj0r9w3uCbdAuF9BP4JO9Vls2pG3RjD85x minkygit"
    ];
    home = "/var/lib/forgejo/repositories";
  };
  systemd.services.hg-serve = {
    enable = false;
    description = "A systemd service for hg-serve";
    serviceConfig = {
      ExecStart = "${pkgs.mercurial}/bin/hg serve --web-conf ${
          pkgs.writeText "" ''
            [paths]
            / = /srv/conical/repo/**
          ''
        } --port 3080 --config web.allow-archive=zip";
    };
    wantedBy = [ "multi-user.target" ];
  };

  services.forgejo = {
    enable = true;
    user = "git";
    group = "git";
    settings.DEFAULT = { APP_NAME = "Minky Forgejo"; };
    settings."ui.meta" = {
      AUTHOR = "Minky Forgejo";
      DESCRIPTION = "The Minky git server running Forgejo";
    };
    settings.server = {
      ROOT_URL = "https://git.matestmc.ru";
      DOMAIN = "git.matestmc.ru";
      HTTP_ADDR = "0.0.0.0";
      HTTP_PORT = 3080;
      # this is not forwarded through cloudflare, so only i can access it because it's on my lan
      SSH_PORT = 22;
    };
    settings.service = { DISABLE_REGISTRATION = true; };
  };
}
