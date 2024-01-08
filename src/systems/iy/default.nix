{ config, lib, pkgs, ... }:
{
  imports = (
    map
      (file: ../../modules/${file}.nix)
      [
        "boot"
        "hypr"
        "river"
        "magic"
        "network"
        "nvidia"
        "packages"
        "pretty"
        "users"
        "i3"
      ]) ++ [ ./hardware-configuration.nix ];
  # services.openssh.enable = true;
  # services.openssh.settings.PermitRootLogin = "yes";
  # services.openssh.settings.PasswordAuthentication = true;
  system.stateVersion = "23.11";
}
