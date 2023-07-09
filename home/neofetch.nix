{ pkgs, ... }:
{
  home.packages = [ pkgs.neofetch ];
  home.file.".config/neofetch/config.conf".source = ./neofetch.conf;
}
