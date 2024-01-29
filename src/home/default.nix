{ pkgs, osConfig, ... }:

{
  imports =
    [
      ./neofetch.nix
      ./pretty.nix
      ./configs.nix
      ./packages.nix
      ./fish.nix
      ./hypr.nix
      ./river.nix
      ./hyperfox.nix
      ./nvim.nix
      # ./i3.nix
    ];
  home.username = "ilya";
  home.homeDirectory = "/home/ilya";
  home.stateVersion = osConfig.system.stateVersion;
  programs.home-manager.enable = true;
}
