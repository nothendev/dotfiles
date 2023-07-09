{ pkgs, osConfig, ... }:

{
  imports = [ ./neofetch.nix ./pretty.nix ./configs.nix ./packages.nix ];
  home.username = "ilya";
  home.homeDirectory = "/home/ilya";
  home.stateVersion = osConfig.system.stateVersion;
  programs.home-manager.enable = true;
}
