{ pkgs, osConfig, ... }:

{
  imports =
    [
      ./neofetch.nix
      ./pretty.nix
      ./configs.nix
      ./packages.nix
      ./fish.nix
      ./nvim.nix

      # Hyprland module
      ./hyprland.nix

      ../desktop/hypr.home.nix
      ../desktop/river.home.nix
    ];
  home.username = "ilya";
  home.homeDirectory = "/home/ilya";
  home.stateVersion = osConfig.system.stateVersion;
  programs.home-manager.enable = true;
}
