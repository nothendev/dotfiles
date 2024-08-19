{
  imports = [
    ./meh.hardware.nix
    ../os/boot.nix
    ../os/magic.nix
    ../os/pretty.nix
    ../os/nvidia.nix
    ../os/packages.nix
    ../os/users.nix

    ../desktop/hypr.os.nix
    ../desktop/river.os.nix
  ];
  networking.hostName = "meh"; # Define your hostname.
  # networking.wireless.enable = true; # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.
  time.timeZone = "Europe/Moscow";
  i18n.defaultLocale = "en_US.UTF-8";
  # services.openssh.enable = true;
  # services.openssh.settings.PermitRootLogin = "yes";
  # services.openssh.settings.PasswordAuthentication = true;
  #virtualisation.docker.enable = true;
  #virtualisation.oci-containers.backend = "docker";
  system.stateVersion = "23.11";
}
