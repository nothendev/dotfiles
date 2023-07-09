{ config, pkgs, osConfig, ... }:
{
  programs.kitty = {
    enable = true;
    package = pkgs.kitty;
    font = {
      name = "JetBrainsMono Nerd Font Mono Regular";
      size = 14;
    };
    shellIntegration.enableFishIntegration = true;
    extraConfig = ''
      background_opacity 0.5
      disable_ligatures never
    '';
  };
}
