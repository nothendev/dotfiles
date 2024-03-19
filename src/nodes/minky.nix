{ pkgs, ... }: {
  imports = [
    ./minky.hardware.nix
    ../os/services/mattermost.nix
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
  ];

  services.cloudflared = {
    enable = true;
    tunnels."b962a0e8-d103-4275-a301-4b40208de026" = {
      credentialsFile =
        "/var/lib/cloudflared/b962a0e8-d103-4275-a301-4b40208de026.json";
      ingress."mm.matestmc.ru".service = "http://localhost:8065";
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
}
