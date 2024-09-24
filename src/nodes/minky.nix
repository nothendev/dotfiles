{ pkgs, ... }:
{
  imports = [
    ./minky.hardware.nix
  ];
  deployment = {
    targetHost = "192.168.23.46";
    targetUser = "root";
  };
  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;
  nix.extraOptions = ''
    keep-outputs = true
    experimental-features = nix-command flakes
  '';

  environment.systemPackages = with pkgs; [
    neovim
    wget
    curl
    git
    bat
    btop
  ];

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
  services.openssh.settings = {
    PermitRootLogin = "yes";
  };
}
