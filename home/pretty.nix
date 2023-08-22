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

  gtk = {
    enable = true;
    iconTheme = {
      name = "WhiteSur-Dark";
      package = pkgs.whitesur-icon-theme.override { themeVariants = [ "purple" ]; };
    };
    theme = {
      name = "Catppuccin-Mocha-Compact-Sapphire-dark";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "sapphire" ];
        size = "compact";
        tweaks = [ "rimless" "black" ];
        variant = "mocha";
      };
    };
    font = {
      name = "JetBrainsMono Nerd Font Mono";
      package = null;
      size = 10;
    };
  };
}
