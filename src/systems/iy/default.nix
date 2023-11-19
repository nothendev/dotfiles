{ config, lib, pkgs, ... }:
{
  imports = (
    map
      (file: ../../modules/${file}.nix)
      [
        "boot"
        "sway"
        "magic"
        "network"
        "nvidia"
        "packages"
        "pretty"
        "users"
      ]) ++ [ ./hardware-configuration.nix ];
  system.stateVersion = "23.11";
}
