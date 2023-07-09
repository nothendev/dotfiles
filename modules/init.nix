{ config, pkgs, osConfig, ... }:
{
  imports = [
    ./boot.nix
    ./hypr.nix
    ./magic.nix
    ./network.nix
    ./nvidia.nix
    ./packages.nix
    ./pretty.nix
    ./users.nix
  ];
  system.stateVersion = "23.11";
}
