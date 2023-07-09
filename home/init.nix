{ pkgs, osConfig, ... }:

{
  imports = [ ./home/neofetch.nix ];
  home.username = "ilya";
  home.homeDirectory = "/home/ilya";
  home.stateVersion = osConfig.system.stateVersion;
  programs.home-manager.enable = true;
}
