{ config, pkgs, ... }:
{
  programs.kitty = {
    enable = true;
    package = pkgs.kitty;
    font = {
      package = pkgs.monocraft;
      name = "Monocraft Nerd Font";
      size = 14;
    };
  };
}
